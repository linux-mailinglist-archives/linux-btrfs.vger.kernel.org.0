Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF6515CB8D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 20:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgBMT6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 14:58:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42409 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgBMT6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 14:58:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so3589574pfz.9
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 11:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ESEGPLBxVfjT2kBbKoKoz+3Z+VqmDzjIaUh0PzYp5rM=;
        b=y2pd4cE1bet5nOBxAp+qAE6BJxDuEjgRHGjRfFejbIF4uFlzZu3/ewT/SY+lNL4n5P
         kbprtILOpHxOiXA7Nr5a/CW6a3Ga2Klnbto5Y8Hkhn1mhtIipDij6HAwyYeb5VER32cz
         xVlbbGf2p0I2PLtXknnsOgB//PXTPO+fFQ99IhHMY1z87FzyZywxGHy7SwLFxZNLpiF9
         qZdj186XQ126uMQsRXnV68vOD4TvDtuLaGvzBsicjR5VqJVq+mPlRc9OtTbwW/N3EUBq
         CxXHO0Vf8aE1dEaTAIBBdByMPWNXP+rmh/9A5YAq1qpvC+kxp3nyHtCmII+y09L3Pn5h
         e7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ESEGPLBxVfjT2kBbKoKoz+3Z+VqmDzjIaUh0PzYp5rM=;
        b=C2aEFfaQ/jM76kx409EXtiMniO2CiIeND40PHdoGFtMRgqNhmVpfNFeP64wzkf6EZo
         d5gm7eKlreTYALxclOoFag0osyDCz3S0EBtSPik9ICaJgT55eyHV0tzE9CaNDZeAbXCN
         tmD+A7VQB8XoGYp9up9JWLhd5INypj+FXGm2xUm3l42xhDijXMnKkOM5Z2r9/Xhpze5+
         rPrwa0lTi+rLWtFY1t9PAxEkCs0FdSvIeeOxnKax0Th1XMLtJuDLCEaPiJpIDixbN8Nh
         AbgsOsDG4GNNVzgBAufp0kp+c1EppobvZTPkTbC7pGRYz22cnWqUJoydKVpm59JUP5BV
         sq9A==
X-Gm-Message-State: APjAAAU8gV/UNLLOeFrFuh8/nqkmOWmT2NUwm9InwoBlsSc4Kr3Iive2
        ton4YXOEQej5B5SXR05ffJRHFwtf+Ao=
X-Google-Smtp-Source: APXvYqzG/7bQWYFe6byNlvMQXDFoL0OfgFR1CfDQTHtvAFLkJ6pLEQXQNxjVnJI7PLiCKveEVV/K6A==
X-Received: by 2002:a63:9dcd:: with SMTP id i196mr19443489pgd.93.1581623933377;
        Thu, 13 Feb 2020 11:58:53 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id z30sm4313411pfq.154.2020.02.13.11.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:58:52 -0800 (PST)
Subject: Re: [PATCH v2 18/21] btrfs: drop unnecessary arguments from
 find_free_extent_update_loop()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-19-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <04796698-dbd7-4d7c-eec0-1ea5ecf90804@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:58:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-19-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Now that, we don't use last_ptr and use_cluster in the function. Drop these
> arguments from it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
