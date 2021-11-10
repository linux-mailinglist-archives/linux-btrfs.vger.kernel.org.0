Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1573A44BA7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 03:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhKJC6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 21:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhKJC6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 21:58:10 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362FC061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 18:55:24 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id v3so1785379uam.10
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 18:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=3CO92oRnXojz7rVBUiXiTNB8foKL2ur/KOJyJGBJrqc=;
        b=NkigK8uniAZKOXhxnhEag+UqCQWgsE5Ct5TAA1UZ+SbwSj+qdPesB8ZtR667L9Dq29
         K0dewpimxtdjg5cjUzEC03IjfwL+0yXXH/bdulHRo+f/pG1Kk15511v4ibQyVl1WgcTe
         DEgBu7l5VyW5Hwa1vza1J/uRmLvHCB1iIxEN76+MZX1f5GJv74RerZptBbunOu57E3z/
         zm5yNoFAB/7Hox7TwyxuGKV0ZRFp9MpOU77zjSnfGYIFYzwwGn8RFGAvTvC2d5JUTyzE
         hBEveV2zN9tRrytO0k7dsiVWLbPNz7ITwJu9O7jKicx5N4eC3PlxfL5JNSdNl849cxRx
         bjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=3CO92oRnXojz7rVBUiXiTNB8foKL2ur/KOJyJGBJrqc=;
        b=v9qIqNRPc5DnWDXC71/SXnhvYDs+KCF6SDkhZKFn2i3ZpQu2jl20TK3dkoMBxd2BGm
         vyQOEjnUJPKyAnpZ+tSdDdmmfcsx5CXegtHpn5fqENLV++WyC8r3cHliR5QHIp1T3dHL
         Wg23jI8nWzynuBXAVQ08cmvF00jA4TiEh5KJUNFnWvgiIKKDzS/t4KkRxf02tmNC0nEv
         zGG9ainDMlXjNjRT556zlsBUbbiDHeR45oZYhVokPKkyXxik4keuoLyB2xkm3Bz7p3Z4
         1kbgXvBBiFBDMhr6go0OQ03NR06m0d1SFN3vUayoRqOpo5iX8u3cP5P5iQrqLSsCSTsq
         YBmQ==
X-Gm-Message-State: AOAM532rBWdLF4q5qo8F8bLuwWj4xN1HM3RBMuId/WdUOcwto714WMDC
        4MqtMqhkQmgvbpojaz+/NQxD8kr/F2E=
X-Google-Smtp-Source: ABdhPJz/ZuwZlXf9JnKGVOaCT0uIvO1R36j9qJRwELLQ0aipj/n7KUkoAITSlVpyvbypKS0Ili9xJg==
X-Received: by 2002:a05:6102:c4e:: with SMTP id y14mr4762907vss.61.1636512922824;
        Tue, 09 Nov 2021 18:55:22 -0800 (PST)
Received: from ?IPV6:2800:370:144:81b0:f245:e007:48ea:38b5? ([2800:370:144:81b0:f245:e007:48ea:38b5])
        by smtp.gmail.com with ESMTPSA id l28sm2437376vkn.45.2021.11.09.18.55.21
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 18:55:22 -0800 (PST)
Message-ID: <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
Date:   Tue, 9 Nov 2021 21:55:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Firefox/88.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
From:   "S." <sb56637@gmail.com>
To:     linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
In-Reply-To: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu, thank you very much for your fast response!

Regarding memtest, normally in Linux I have never been able to run it from inside an installed Linux system because it needs access to protected kernel memory, and instead it has to run from a live USB or from the memtest86 live testing image. But since this system is a proprietary NAS with uboot and no video interface I don't know how to run a memtest.

> To be extra safe, please provide the dump of your UUID tree:

------------------
root@OpenMediaVault:~# btrfs ins dump-tree -t uuid /dev/sda3
btrfs-progs v5.10.1
uuid tree key (UUID_TREE ROOT_ITEM 0)
leaf 170459136 items 4 free space 16151 generation 366 owner UUID_TREE
leaf 170459136 flags 0x1(WRITTEN) backref revision 1
fs uuid 4a057760-998c-4c66-aa6a-2a08c51d5299
chunk uuid 54b2fa0f-9907-49d1-af33-e172581cd25e
	item 0 key (1101835439474057344 EXTENT_ITEM 56168916570538915) itemoff 16275 itemsize 8
	item 1 key (0x0f4a817e92c9a080 UUID_KEY_SUBVOL 0xc78d54ff9b03a3a8) itemoff 16267 itemsize 8
		subvol_id 5
	item 2 key (0x421cfa6924ef510d UUID_KEY_SUBVOL 0xc8423812cf31288b) itemoff 16259 itemsize 8
		subvol_id 269
	item 3 key (0x45a64f82bc9152f1 UUID_KEY_SUBVOL 0x3859efe8688d6ea4) itemoff 16251 itemsize 8
		subvol_id 274
total bytes 1990110658560
bytes used 704343715840
uuid 4a057760-998c-4c66-aa6a-2a08c51d5299
------------------
