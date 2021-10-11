Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1954296FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhJKSh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 14:37:57 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:50375 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229542AbhJKSh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 14:37:56 -0400
Received: from venice.bhome ([78.12.10.152])
        by smtp-17.iol.local with ESMTPA
        id a09RmP1azUpwUa09Rm5FJ8; Mon, 11 Oct 2021 20:35:54 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1633977354; bh=JqQItFeAvquFgBBxW1CT5ClbXiGzO8sJL2dCMBTnA+M=;
        h=From;
        b=A7FcOS3xrbI3j2Y+jxWB0mPcB2In+gbDoNswJERSQ/NNx+YL6OLa5tBHO3URpcKSe
         iDC+WDc95HV/xAv6lG6/wy3i2QFU8GQF6+taWlAQT88P1hTSsEjr/coOofL5Ik6UJE
         pPa+SEH+8sne53wn2AiReFtKsMnVYr3cMbZj0NeLNE9eoZdLvcVpRmNb7yypTsFNAt
         mK3Gw2X4osTS2lvrK7FTaUblANKauk06LdbWz6rd+tbJDG4pQtCJQnNBWFk0C3gUUn
         sFGqOgEhzVww0YM0oHAnQPdFFDD2KoTVYkdQiNiko8HPiZ5CaJTNo1NgialXYsc05X
         ugnkx+ihQUd0A==
X-CNFS-Analysis: v=2.4 cv=MJylJOVl c=1 sm=1 tr=0 ts=6164840a cx=a_exe
 a=EzK6Ev+Ndi4VoAiPDBu8Fw==:117 a=EzK6Ev+Ndi4VoAiPDBu8Fw==:17
 a=IkcTkHD0fZMA:10 a=lBieLZBSNK-9T2mtmN0A:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v2 00/10] btrfs-progs: mkfs fixes and prep work for extent
 tree v2
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
 <20210825135839.GK3379@twin.jikos.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <03ae7a36-dbc9-bfad-6ec7-45e929f862a7@libero.it>
Date:   Mon, 11 Oct 2021 20:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210825135839.GK3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJyZk9Cn/er3o/nmv5hpj6dGmXy9+Gy1TssHegMofLi4h9ZStnTMfxleUMsJf8tPkYla3cie23Q6Zs7JhAt+HnmV4Wenf82FWOY0DlzMb6rczRoNzbe2
 Kejc7zj3LC2QWtozRRNy6lr7tMKrmzBQ+abLTPgbsn+j9yAF5BDhz6ImnaVc3rIBZ2YRicrtf+Z6y+A7byD0fkn4A/8oVIQLQRcyw/GIUcrOTKWvCYh2A9E2
 kYpGdAE83plkkECb0s/GIViMYxCJuDvnzdG8qNmG9CM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/25/21 3:58 PM, David Sterba wrote:
> On Mon, Aug 23, 2021 at 04:14:45PM -0400, Josef Bacik wrote:
[...]
> Even with the "if (EXTENT_TREE_V2)" in place it becomes the
> implementation and given that I haven't read the whole design doc for
> that I'm worried that once I find time for that and would suggest some
> changes the reply would be "no I did it this way, it's implemented,
> would require too many changes".

Just for curiosity, is there anywhere a design doc for extent tree v2 ?

BR
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
