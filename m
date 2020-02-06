Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAD91548CD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBFQH7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 11:07:59 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36277 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBFQH7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 11:07:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id w25so6056760qki.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eq3piDj8jKAFLmxP2KZ9VSOcO8UDniVQrrVahdOHA5Q=;
        b=ov55h5+BgbIe0D5yCrxIc0pUrt9PvP9NnLsPgG1X3KiEV36O0g4TMH2B4mkgJu1bBE
         rRbd3uNvlWK9V3M2O4szQ9ZQrCT5XJfZrfy/qYJjJDEmSEBHxH8XFsXIcfA6zBCneHNp
         RGGePKFxzEtgx7wp3+m8kSAsSaFUVyrXyrzd/reF4NwLWRDBoU4K93yOKbLS3wzcAQdv
         +U17X57ITnc6BFYl1p5J+EfzZ7cul5l+T0HpI6QtVzKeXQ4kvZ2Z4Nyr5LSIN5wxWY65
         54qzT3FWbnqtShJ002VfKGuK9S5K+F5iqjORTlAscpMBoie+8/T+LNCFVz/fRCy8nAre
         INPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eq3piDj8jKAFLmxP2KZ9VSOcO8UDniVQrrVahdOHA5Q=;
        b=e/lOHkwoehjrHbRxY/7rR8sh4Mn6RHfOoVbsLcN4As2XN2A4vVwMNJFcTeSKm3i7nt
         3c6aw9oXmg547t2UxgwYaN6v/3SJqNDCn5Vjmmu5pycc76gZ9yq/tlKqUZX3fUPMozZI
         pqeHnkLVCV+4lugJZtsAr1j+phBHH8zlL9O0/oMcKb7xwjTodMNgys3ZvXrumOeptBPD
         VfxCkdpMg36tHeyyLEHGXVZ8y7+0uqPCd/ut/G8zmjiZo6wFlLiZAQLtpL+OERpbF9/T
         B9w9+xiowrN+AZsY/OHjD9xVnojNCWzziSyjJsYhwKbt0Fohr8RXvgTuMIfHpNQkHRnj
         vs3g==
X-Gm-Message-State: APjAAAU3YoNsjUoTMWfWEUqhydDxuH222+93Y2Sl/9NrP/TCTUiRISQr
        fVS4hN0p1MRvlVOJKt9lVJm+MA==
X-Google-Smtp-Source: APXvYqwLng2wowAydmJ6JgM/foZWVFcunHLc12K6X/dCiTPwu9ONE7pL1fgFhA/d9Gc3WEUM6sPuvg==
X-Received: by 2002:ae9:f50c:: with SMTP id o12mr3249146qkg.42.1581005278225;
        Thu, 06 Feb 2020 08:07:58 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d9sm1803939qth.34.2020.02.06.08.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:07:57 -0800 (PST)
Subject: Re: [PATCH 02/20] btrfs: introduce chunk allocation policy
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-3-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bf1a4a98-76b6-b570-a068-f082170b1f39@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:07:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-3-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 5:41 AM, Naohiro Aota wrote:
> This commit introduces chuk allocation policy for btrfs. This policy
                           ^^
                         chunk

> controls how btrfs allocate a chunk and device extents from devices.
> 
> There is no functional change introduced with this commit.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Of course then I notice my mail client re-ordered your emails and it was 
actually in the next patch.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to this.  Thanks,

Josef
