Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4108021D81F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 16:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgGMOQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbgGMOQ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 10:16:27 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E83C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 07:16:27 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j80so12298230qke.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JYG+/n0SB+OBWBgBLFN9hBh2Tv0dKziKTDnGkYeJ6P0=;
        b=ovDmynkXfbdRpDwgMgVaf4IySwYvaEIRySVD9zLdwGXx9JaJYxMVQ70Z+sYqyMzr4b
         3bMv0jSD9q5384tINbg4FjPF4idQphQhg9xn37CuW1sqn9tVA9UsgIMH+GfOWKf7j34m
         QnGk3sWwRd21iSyWp5PWjdNvmTxzrj3Dn1XHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JYG+/n0SB+OBWBgBLFN9hBh2Tv0dKziKTDnGkYeJ6P0=;
        b=rUaZGF4CdTzliGYx/l9Ulj/+HNFhIoockuTyVS7M/03csXOpHYW+/X91bzLRmDjhSR
         f5kUaHEttnh/a7Cj0wCWOrcwKKYKDmspm85YCAfgp/Fudx2q0VLFNbw4ly+MIWH5ePPN
         776eknirJlWlJT4jqoOFy6WXDp7+ljL76uOn7RJ9FFbTMPCrssCx1jLGCTzFjYNtx+HF
         qUDv9OQdAE+8LfP6yj6GW3/K4dFlV4wivunfUpWJigfyKxrW+zlRIrdvyKSFqPNgy92k
         YiJpGsWi6XEEpM0D6rU56LLP1fwpIYo4iw4/tjkbQrKKhCvUQhku4QwDtYNd3BkSOCEP
         aIqQ==
X-Gm-Message-State: AOAM530EOHd/dmsOsFUM41hs20f5WqlyB8dNnJzU31rreLyjivl17VfY
        NfOZfgT/+NVLv8nYlPFI8zivwTJ0KvGc0g==
X-Google-Smtp-Source: ABdhPJyd5Is9IMACQyqa4BvifOV85gx8QrkNw2fIzqx+cMjghle+RkHCiW+B3c+u7H9+J5+alczwbA==
X-Received: by 2002:a05:620a:1ee:: with SMTP id x14mr79162244qkn.453.1594649786016;
        Mon, 13 Jul 2020 07:16:26 -0700 (PDT)
Received: from [192.168.1.9] (pool-72-83-172-153.washdc.east.verizon.net. [72.83.172.153])
        by smtp.gmail.com with ESMTPSA id c7sm20843645qta.95.2020.07.13.07.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 07:16:25 -0700 (PDT)
Subject: Re: balance failing with ENOENT
To:     A L <mail@lechevalier.se>, linux-btrfs@vger.kernel.org
References: <5bc91ff8-1764-203d-53e1-a691b1b5abf9@pefoley.com>
 <798d01f.397441d9.1733fb56693@lechevalier.se>
From:   Peter Foley <pefoley2@pefoley.com>
Message-ID: <6d862426-f260-0617-c529-248e941b4124@pefoley.com>
Date:   Mon, 13 Jul 2020 10:16:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <798d01f.397441d9.1733fb56693@lechevalier.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/11/2020 5:08 PM, A L wrote:
> 
> 
> ---- From: Peter Foley <pefoley2@pefoley.com> -- Sent: 2020-07-11 - 21:39 ----
> 
>> Hi,
>> I've got a btrfs filesystem that started out using the single profile.
>> I'm trying to convert it to raid1, but got a strange error when doing so.
>> Note that this only started happening after the initial balance got canceled part-way through.
>>
>> btrfs balance start -dconvert=raid1,profiles=single /
>> ERROR: error during balancing '/': No such file or directory
>> There may be more info in syslog - try dmesg | tail
>>
> 
> You can try "btrfs balance start -dconvert=raid1,soft /" 
> 
> 'soft' avoids balancing chunks that are already in the target profile. *
> 
> * https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-balance#FILTERS 
> 
> 
> 

No dice, exact same failure mode:
btrfs balance start -dconvert=raid1,soft /                                                                                                                                                                                    ERROR: error during balancing '/': No such file or directory                                                                                                                                                                            There may be more info in syslog - try dmesg | tail

[146628.913952] BTRFS info (device sda3): balance: start -dconvert=raid1,soft                                                                                                                                                           [146628.914403] BTRFS info (device sda3): relocating block group 968545533952 flags data                                                                                                                                                [146648.475913] BTRFS info (device sda3): found 11 extents, stage: move data extents                                                                                                                                                    [146649.198865] BTRFS info (device sda3): balance: ended with status: -2          
