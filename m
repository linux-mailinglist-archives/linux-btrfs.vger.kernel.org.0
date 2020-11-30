Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCED2C8775
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 16:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgK3PL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 10:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgK3PL0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 10:11:26 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDCEC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 07:10:46 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id v143so11057305qkb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 07:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xc7f1JhoomYyQk9isGwNBbplo0tPvOs3JhlMchjulc8=;
        b=kyDn1hVz9uqGbNwBkX9F6k2YPsCEGME54HBo6wa5d85+12nR8HyJkFpxWlZWu4Hcj9
         sdvz5T4ciRLEaMj8wBe63OHAAxQK98Ppwq/O2M3kkobUFnQClkouyj7cuih+dyxAbTFo
         EdGmTz9vrrolp42F2XC5sPhCzGc9jai2HPP2sVynSfjH7rm7PCaya5VDMHgiGHzdINRR
         esWt2lMDRPXpO171AH+OArqQui223pCWMo5vDvMZbN05tH1W82gvOrEwRLu0lzyaomLZ
         N/bXmsSFXNIW3qv4CqsLlJfSMKISoeJEabD+kZjwYRu413G9jJacwejYYM15JBPMDKRQ
         L54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xc7f1JhoomYyQk9isGwNBbplo0tPvOs3JhlMchjulc8=;
        b=oR7TEm86TyGsziqiuMOSyHD01OluxGszkzdbz+hwOgdtpkJ8Fl//CgX/0ESVG8NNsx
         X8kYEpk2J1FcIEAqcuF8ILafgsb2OZNhLjcVrGnTEmqNjgFFH8vE4nXeZKEOahLQQ+rV
         ygpPdP+3PYWd88evLKyqDjuHJfxulABO2e/a+k5JqTr+u7YFlPJ+2D74HT9+gpkzmpiI
         zcHZNXErguDXhaaet48bfV+cQC5xvfWyAx9T5quZVXcoTHKo9mC8R7xxNpeQsb2Er8Ye
         FW9g1xrpa0dtfgLdIqE3oreReyeHEDBKB5aXQg4qqTry/rTjQRHO096uPkOvPrinwPY3
         WphA==
X-Gm-Message-State: AOAM532Z9jhJtWD9FbCmZhqGvBGaAT510EH5jhIyzUse4Z6pSORqfRzZ
        ryY6nH6lnI86urUv9im5GOR7yw==
X-Google-Smtp-Source: ABdhPJz6w86bJPpl6v+c6opxvN5PArI+R8Lmqqt1WaJTlEULf1NPmR8JpuN29l2xaMLkdZPknweZlg==
X-Received: by 2002:a37:68d5:: with SMTP id d204mr23478986qkc.198.1606749045212;
        Mon, 30 Nov 2020 07:10:45 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o13sm14874063qkm.78.2020.11.30.07.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:10:43 -0800 (PST)
Subject: Re: [PATCH] btrfs: do not allow -o compress-force to override
 per-inode settings
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com>
 <20201130190805.48779810@natsu>
 <b92d0141-f68f-ce96-8099-e145ebc6f594@toxicpanda.com>
 <20201130200116.79a710fe@natsu>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <df787c30-8a5e-0256-a4c9-baa3e3556a39@toxicpanda.com>
Date:   Mon, 30 Nov 2020 10:10:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130200116.79a710fe@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/30/20 10:01 AM, Roman Mamedov wrote:
> On Mon, 30 Nov 2020 09:50:13 -0500
> Josef Bacik <josef@toxicpanda.com> wrote:
> 
>> The thing you're missing is that when we do chattr -c we're setting NOCOMPRESS
>> on the file.
> 
> Wow, and does this need a previously set +c to work? Or just -c on an already
> -c file will change the Btrfs flag under the hood? Seems to be very weird in
> any case, as from the user perspective there's no way to view the current
> status of that flag, with the only way to change it being via a side-effect of
> another operation.
> 
>>    If chattr -c is supposed to just be the removal of +c, then btrfs is doing the
>> wrong thing by setting NOCOMPRESS.
> 
> I would agree with that.
> 
>> I guess the question is what do we want?  Do we want to only allow the user to
>> indicate we want compression, or do we want to allow them to also indicate that
>> they don't want compression?  If we don't want to enable them to disable
>> compression for a file, then this patch needs to be thrown away, but then we
>> also need to fix up all the places we set NOCOMPRESS when we clear these flags.
> 
> The patch also seems to prioritize "no compress if compression ratio is bad"
> over compress-force, whereas the whole point of compress-force feels to be to
> compress no matter what, especially no matter what are the possibly imperfect
> compression ratio estimates.
> 

Right, but if we have compress-force we don't set NOCOMPRESS if the compression 
is bad, so theoretically we shouldn't ever really have that problem?  But I 
agree, this is a weird source of ambiguity.  I'm thinking the best solution is 
to stop setting NOCOMPRESS except in the bad compression case, and then figure 
out a different mechanism to force no compression and deal with that separately. 
  Thanks,

Josef
