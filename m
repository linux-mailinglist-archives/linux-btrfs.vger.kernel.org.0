Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1C32A9802
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 16:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgKFPBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 10:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgKFPBk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 10:01:40 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DA6C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 07:01:38 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id n132so172301qke.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 07:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gv3NhhJYilcQa5FbCjmuJ9ZNgOEq1qCdNDP7mOzTP3g=;
        b=WU1eEvkrTkBTE+n8eEWxQ7t4CBoEp4URQy7JP1a1k9Czq+v54nRfN89kKywfWiARJf
         onLSgfzeVVoeFx18ODMtiYvv9qJAKFbzjXwckCnepqv9aCy5Z9W7/UOjBJWiDjwgMiLp
         CjDxzs6IKTpTX73qIgseUXYS31GE4j71VYyYOJMYEH89tRzrG7SsQhwBjp2ZTnHhhZL2
         BVhHUVBMo7j8GzYj1NqOnCU2nZK8KKOcnGPujf7d5bAzvmf8dRFB4fTJXLFcgdzCo00a
         L1w9fbil1t7ItJMz16+ax37ekokN2DRKbx4U/FGENTUbLb0CzP+0hIli945CO7+oKrnO
         Bu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gv3NhhJYilcQa5FbCjmuJ9ZNgOEq1qCdNDP7mOzTP3g=;
        b=tb+/KoJwu9Xx74jFFZ0uoJ1Cum5vwdS+JkmUcPHr6boKvtVnaDlK0zGP/rL545Y1f1
         p0M5HriGpUAG8k5vYXrZVNOgWF0yvrCIlqwoXKbakiwS2XWpn/9YdaSa8C//Gh1cQgSd
         VbArtRBrMU/6NSLapPqZMiRn3KTMLtquF1VR3j2fBaSd4bREw6pMsg3CqblUzP6hYNr9
         CxUPgpZA5OSB9BxizIVGz76CRe0EcPquOn+UcoN+PP2ByEW7J0FKTVIZXkUrZfuWbAi3
         x4P+6mGKCkyIaKsUORjiFcqBsygesDhaA04IM0ySvFWHVs/uw4sObZH6raQmpwd5+sns
         H3HA==
X-Gm-Message-State: AOAM532YkPMiabXXxv0/akphYsr6ZizZphHntEQwFG/0XZLwdrVT1Udm
        TxRil+nduVSmCySF5IPARZHjs4zET6pIsd/I
X-Google-Smtp-Source: ABdhPJyeFHZKR/8/Q5FCvuY4JuRkTxXlu3v+50Wgld2madreMoowiskbrhsFw78NGNkjN6Z1+NssaQ==
X-Received: by 2002:a05:620a:c9a:: with SMTP id q26mr1008263qki.272.1604674897939;
        Fri, 06 Nov 2020 07:01:37 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p5sm687353qtu.13.2020.11.06.07.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 07:01:36 -0800 (PST)
Subject: Re: [PATCH v9 19/41] btrfs: redirty released extent buffers in ZONED
 mode
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <b2c1ee9a3c4067b9f8823604e4c4c5c96d3abc61.1604065695.git.naohiro.aota@wdc.com>
 <6d61ed1d-1801-5710-beac-03d363871ec8@toxicpanda.com>
 <SN4PR0401MB35981D8500BE7FAF931F1AEE9BED0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eb12c0db-28e0-13a6-ebaa-2f19bd1be6ee@toxicpanda.com>
Date:   Fri, 6 Nov 2020 10:01:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35981D8500BE7FAF931F1AEE9BED0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/6/20 4:11 AM, Johannes Thumshirn wrote:
> On 03/11/2020 15:43, Josef Bacik wrote:
>> This is a lot of work when you could just add
>>
>> if (btrfs_is_zoned(fs_info))
>> 	return;
>>
>> to btrfs_clean_tree_block().  The dirty secret is we don't actually unset the
>> bits in the transaction io tree because it would require memory allocation
>> sometimes, so you don't even need to mess with ->dirty_pages in the first place.
>>    The only thing you need is to keep from clearing the EB dirty.  In fact you
>> could just do
>>
>> if (btrfs_is_zoned(fs_info)) {
>> 	memzero_extent_buffer(eb, 0, eb->len);
>> 	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
>> }
>>
>> to btrfs_clean_tree_block() and then in btrfs_free_tree_block() make sure we
>> always pin the extent if we're zoned.  Thanks,
> 
> As much as I'd love the simple solution you described it unfortunately didn't work
> in our testing [1]. So unless I did something completely stupid [2] (which always
> is an option) I don't think we can go with the easy solution here, unfortunately.
> 

Actually it's because we're calling btrfs_clean_tree_block() in 
btrfs_init_new_buffer(), so any new block is now getting marked as 
BUFFER_NO_CHECk, hence everything blowing up.

I think first you push btrfs_clean_tree_block() into btrfs_free_tree_block() and 
kill all other callers, because we're just marking it no longer dirty.  In fact 
I'd rename it as btrfs_mark_extent_buffer_clean() or something like that.  Then 
your patch should work just fine.  Thanks,

Josef

