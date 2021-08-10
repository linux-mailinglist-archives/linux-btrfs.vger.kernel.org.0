Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2173E7D38
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhHJQMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhHJQMh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 12:12:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B7C0613C1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 09:12:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e19so8234812pla.10
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fX3lJNFAs6js88H6GjFl1Jc95WMA3P44zHxsjDKgatU=;
        b=iAPjYak864no52uPmDirgNfOpEp1Oh6C+i8eM52Lor1qJzV1uyP85QQ/JJ8z/igbrQ
         7H+LMQuvjgppDAx9m+5g/dG1vXo9/Z1KDum3//w7mpmwAyhZ13DaQzS6hrt0uV2gRiH9
         z6xg3scCLwy86m5pPEhz1sZ+A1MMUcSxTs6x7mqeJa9fs1wkkFoBM23WkISmY9F8HPLv
         m5VDwR6kHEBjJP1Wf+jq6h5oE6fNTZvqntoHUgzKsjiqaQx26HTRUUhYWoU+KqFZAcwO
         eAyGWAWpxVCvn1Gd9a2pqp2HdauVFxeq/f0SfXvIzTN1lzJnHMnHZC4DN35OR9cmRGEE
         3A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fX3lJNFAs6js88H6GjFl1Jc95WMA3P44zHxsjDKgatU=;
        b=gZvrtC0hJ644/40h7qzUhi/gkqri+s7WT4be0pXyIgAAF+gO4Tc0SwLGpCouVEeuT8
         NSbo4bTigrwsjt1cPvp2kRv8vanvXBK+Q89/+415UiI1hgM4mvZxl9g/8wLb7xc97ApM
         fhpylO+y2hF1o9gmMiSDBKxxU73MfLZL9DTMa60LeVrACXbSH1FuN2B+9Iw0herF5s8Y
         Cp6Wx9e/bFcY5rv0CKZ2++Yb7eaNyQZuZcNLZkzCA1xwItPnh6GqYXTaTPocxmdtH+Je
         m487MhFjz6ZjliKzsNispwP7dNdh0qc02KPDDNkG+Rsz0EFj+u5j44ZItTtT2u7ThqMt
         /uYQ==
X-Gm-Message-State: AOAM531P5WG8mm0lxzO4Fj1esj4OEQWAwUJBWg/3t+y4m3evdDzOhavR
        jTCgOBsSA1DggaxrSF+emao=
X-Google-Smtp-Source: ABdhPJw8luQ7eepvnSx4AbdYjyLNIPoKNi/EW5QqUDZwNnIinVg67Lx7nfUOzFleMLNXfCv/Vo3qkw==
X-Received: by 2002:a65:6111:: with SMTP id z17mr963960pgu.335.1628611934775;
        Tue, 10 Aug 2021 09:12:14 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id om9sm3306432pjb.40.2021.08.10.09.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 09:12:14 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
Date:   Tue, 10 Aug 2021 09:12:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> I don't know how to do that (corrupt the extent tree)
>
> There is the more detailed version:
> https://lore.kernel.org/linux-btrfs/744795fa-e45a-110a-103e-13caf597299a@gmx.com/


So, here's what I get:


# btrfs ins dump-tree -t root /dev/sdb3 |grep -A5 'item 0 key (EXTENT_TREE'

    item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
        generation 166932 root_dirid 0 bytenr 786939904 level 2 refs 1
        lastsnap 0 byte_limit 0 bytes_used 50708480 flags 0x0(none)
        uuid 00000000-0000-0000-0000-000000000000
        drop key (0 UNKNOWN.0 0) level 0
    item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439


# btrfs-map-logical -l 786939904 /dev/sdb3

checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
bad tree block 952483840, bytenr mismatch, want=952483840, have=0
ERROR: failed to read block groups: Input/output error
Open ctree failed



Sooooo.. now what..?
