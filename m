Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4739C777
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jun 2021 12:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFEKhg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Jun 2021 06:37:36 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:60096 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFEKhf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Jun 2021 06:37:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id AF3464590B;
        Sat,  5 Jun 2021 12:35:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7_TPGxVMZjiY; Sat,  5 Jun 2021 12:35:45 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id C82713FBCD;
        Sat,  5 Jun 2021 12:35:44 +0200 (CEST)
Received: from [192.168.0.10] (port=59537)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1lpTec-000NAH-2k; Sat, 05 Jun 2021 12:35:44 +0200
Subject: Re: reflink copying does not check/set No_COW attribute and fail
To:     Tom Yan <tom.ty89@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, bug-coreutils@gnu.org
References: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
 <CAGnHSEkeu1hW-7YQO0HrYK__aY-eMdxfgSbcOTvnMu3jUcu4iw@mail.gmail.com>
 <20210604201630.GH11733@hungrycats.org>
 <CAGnHSEk-+2tA21+sN4dioYbs_u4m_NiLPkG8u6ONJS=JbCACoA@mail.gmail.com>
From:   Forza <forza@tnonline.net>
Message-ID: <56d734d0-d0f6-4d64-7b6f-9ea8ad2858d4@tnonline.net>
Date:   Sat, 5 Jun 2021 12:35:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAGnHSEk-+2tA21+sN4dioYbs_u4m_NiLPkG8u6ONJS=JbCACoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-06-05 07:56, Tom Yan wrote:
> As far as I'm concerned, inheriting an attribute from the source inode
> isn't a "surprising" behavior. Rather it seems pretty "natural" to me.
> And I don't think whether the attribute is "dangerous" changes that,
> because if you consider it "dangerous", shouldn't you "watch out"
> anyway when you try to make a clone of a source with such an
> attribute?

I'd agree here. 'cp -a' does mean preserve all attrributes. It is up the 
user to think about consequences copying nodatacow files.

> 
> If we see it from the way that, the kernel does not make the
> destination inherit nodatasum just to make reflink succeed as much as
> possible, but rather it just by design inherit nodatacow (for the
> reason of being NOT surprising), then there's no concern in whether
> they should "decoupled" when we implement the inheritance. (Like we
> can't set only nodatasum with `chattr either. It's simply out of the
> scope then.)
> 
> I don't know if we can do that based on whether the reflink mode is
> always. Though we can fallback to "normal" copy when the source has
> nodatasum (and/or nodatacow), personally I don't find it less
> surprising than inheriting nodatacow all the time.
> 
> By the way, what will `chattr -C` do exactly if the file/inode had
> nodatacow? Is the behavior different when it is / there is a reflink?

You cannot disable nodatacow on a file with existing contents.

There is already a thread from May 2020 on coreutils mailing list about 
the order of copying attributes to solve the issue of nodatacow etc.

Basically, 'cp -a' needs to set some file attributes before adding data 
to them.

https://lists.gnu.org/archive/html/coreutils/2020-05/msg00011.html

