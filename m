Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64491370B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 16:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgAJPHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 10:07:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43721 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgAJPHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 10:07:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id t129so2076303qke.10
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 07:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PdzKcyIWiBFxqPd1gjloVyDSKcCSL6bJYYNI12pfaMQ=;
        b=U4BFadku0UFto9mA+ma2VExhGJSTyw3UPRPgtvOAGW4u5VCP380AP6V6mj1lUTNlqR
         Vd8KigQ3FZhB4RGSTZAI5CI1ebgxWp/1BEdZ7fbp/OVlDDOozQ8iQncoP+WYDCN8w+Jy
         NGfzKu8ZOWmHxm/jpk0KRkoHZPsGdPY5CHttvkq/vsQ7lyFs4MgKycvQWvKgei5YUxyQ
         KJG6IB9QWqNs9yIHoLLCXxXipjNyis21Py6EDiQAnhyChfRvJt8llxZhkEySsUrguPVV
         468KI4XkmX5wpTPfwT4AzmDCZtmMQTnjSGAtAPAPqFEl9623ORggcMkA4BwZnCWmQPlw
         4K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PdzKcyIWiBFxqPd1gjloVyDSKcCSL6bJYYNI12pfaMQ=;
        b=I82naux47WXi2gns+LhB8aBJtagihFP2TrD2apIyc7TAMbc7f+fwcSAd7tfK50ksAG
         OaOk79VY+mFakS2+VmSxqtVAs+hfS+m87qb5Wr+EqmNcyzsskb1iRmZBMOc3GNoMBkWP
         cxNJ1v0MyW21apUrYn54xlPua4r93Fu6kFRAkq/FDv85Yt/eDa/JMYV/p0StzchJrZZz
         WjDkvWKzrmi1ssAzqmwWkEJP4kkLM7zka51I1sdv38HFvc8r/JcU0xC1sqLQpn53Pjee
         7LhgO8f3YVvMqE3aZic0Kj/XoFA7Yp1y3Ub6YaO4DnlnzoKlIZJhwI8TXl/mhptKvQQg
         vfvQ==
X-Gm-Message-State: APjAAAW5iPQcwEd/hXUeTj6E4rudjilP1kXGqTXkjXFZDMpMWPB750XD
        p++4PlmhMHoYWvcrTxSIYzKKvIGq/NIfrA==
X-Google-Smtp-Source: APXvYqw3T8avqTYqPF1l1TCLPQwMLotGJc4j8M+bx9/Xuvzu2PYLXWx4TGe9o5uUPYpfbONUE7RMoQ==
X-Received: by 2002:a37:2e47:: with SMTP id u68mr3499433qkh.485.1578668866250;
        Fri, 10 Jan 2020 07:07:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4dc2])
        by smtp.gmail.com with ESMTPSA id o55sm1119274qtf.46.2020.01.10.07.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 07:07:45 -0800 (PST)
Subject: Re: [PATCH] btrfs: device stat, log when zeroed assist audit
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20200110042634.4843-1-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7b449175-4e73-7fe9-07b2-d1c04feeba8e@toxicpanda.com>
Date:   Fri, 10 Jan 2020 10:07:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110042634.4843-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 11:26 PM, Anand Jain wrote:
> We had a report indicating that some read errors aren't reported by
> the device stats in the userland. It is important to have the errors
> reported in the device stat as user land scripts might depend on it to
> take the reasonable corrective actions. But to debug these issue we need
> to be really sure that request to reset the device stat did not come
> from the userland itself. So log an info message when device error reset
> happens.
> 
> For example:
>   BTRFS info (device sdc): device stats zeroed by btrfs (9223)
> 
> Reported-by: philip@philip-seeger.de
> Link: https://www.spinics.net/lists/linux-btrfs/msg96528.html
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   BTRFS info (device sdc): device stats zeroed by btrfs (9223)
> The last words are name and pid of the process, unfortunately it came out
> as 'by btrfs'. At some point if there is a python and lib to reset it
> would change, otherwise its going to be 'by btrfs', I am ok with it,
> if otherwise please suggest the alternative.

I think name(pid) makes sense, similar to what drop_caches does

pr_info("%s (%d): drop_caches: %d\n",
	current->comm, task_pid_nr(current),

Thanks,

Josef
