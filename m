Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE353B52EE
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jun 2021 12:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhF0K67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Jun 2021 06:58:59 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:48758 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhF0K64 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Jun 2021 06:58:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id D22BE3F39C;
        Sun, 27 Jun 2021 12:56:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y2lkU5931y7i; Sun, 27 Jun 2021 12:56:29 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id AD5183F319;
        Sun, 27 Jun 2021 12:56:28 +0200 (CEST)
Received: from [192.168.0.10] (port=52546)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@lechevalier.se>)
        id 1lxSSh-000IY6-Po; Sun, 27 Jun 2021 12:56:27 +0200
Subject: Re: bug#48833: reflink copying does not check/set No_COW attribute
 and fail
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Paul Eggert <eggert@cs.ucla.edu>
Cc:     48833@debbugs.gnu.org, linux-btrfs@vger.kernel.org,
        Tom Yan <tom.ty89@gmail.com>
References: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
 <CAGnHSEkeu1hW-7YQO0HrYK__aY-eMdxfgSbcOTvnMu3jUcu4iw@mail.gmail.com>
 <20210604201630.GH11733@hungrycats.org>
 <CAGnHSEk-+2tA21+sN4dioYbs_u4m_NiLPkG8u6ONJS=JbCACoA@mail.gmail.com>
 <20210606054242.GI11733@hungrycats.org>
 <4354c814-9f9f-0c26-fb11-36567da6f530@cs.ucla.edu>
 <20210608024144.GB11713@hungrycats.org>
From:   A L <mail@lechevalier.se>
Message-ID: <14a60f28-6a74-3315-b756-56ee4b84d583@lechevalier.se>
Date:   Sun, 27 Jun 2021 12:56:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210608024144.GB11713@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 2021-06-08 04:41, Zygo Blaxell wrote:
 > On Sun, Jun 06, 2021 at 10:47:05PM -0700, Paul Eggert wrote:
 >> On 6/5/21 10:42 PM, Zygo Blaxell wrote:
 >>> If cp -a implements the inode attribute propagation (or 
inheritance), then
 >>> only users of cp -a are impacted.  They are more likely to be aware 
that
 >>> they may be creating new files with reduced-integrity storage 
attributes.
 >>
 >> True, although I think this aspect of attribute-copying will 
typically come
 >> as a surprise even to "cp -a" users.
 >
 > Existing users might be surprised when "cp -a" starts replicating storage
 > attributes when it did not do so before, but I suspect most future cp
 > users would expect "cp -a" to preserve storage-policy attributes the same
 > way it currently preserves ownership, permissions, timestamps, extended
 > attributes, and security context--a list that initially contained only
 > the ownership, permissions, and timestamps in the past, the others were
 > added over time.  If not by default, then at least have the ability to
 > do it when requested with a "--preserve=datacow" switch.

...

 > The cp doc could be clearer that filesystems that support reflink
 > don't guarantee every file can be reflinked to every other file.
 > reflink is expected to fail in a growing number of cases over time,
 > as more filesystem features are created that are incompatible with it
 > (e.g. encryption, where reflinks between files with different owners 
could
 > be unimplementable).  I've seen a number of users get burned by 
making big
 > --reflink=always copies and not checking the results for errors, assuming
 > that only lack of space for metadata could cause a reflink copy to fail.
 > There are good reasons why --reflink=auto exists and is the default,
 > and users ignore them at their peril.
 >

Hello everyone,
I made a similar thread[1] about a year ago on the coreutils 
mailing-list and I think it is also relevant to this bug-report.

It is true as Zygo mentions, that reflinking nocow and cow files does 
not work, and cannot work due to the nature of how nocow works.

What I would like to add to this bug-report is what elaborated on in the 
other thread, that we can move forward with preserving all attributes by 
setting them in the correct order. I show in the message that reflinking 
works between two nocow files and that ‘cp -a’ could preserve nocow and 
other attributes if ‘cp -a’ sets those attributes in correct order.

As a normal end-user, IMHO, ‘cp -a’ should preserve all attributes where 
possible, which is also what the manual[2] currently states:

‘--archive’
Preserve as much as possible of the structure and attributes of the 
original files in the copy (but do not attempt to preserve internal 
directory structure; i.e., ‘ls -U’ may list the entries in a copied 
directory in a different order). Try to preserve SELinux security 
context and extended attributes (xattr), but ignore any failure to do 
that and print no corresponding diagnostic. Equivalent to -dR 
--preserve=all with the reduced diagnostics.


Only when using --reflink=always, we should fail if the target cannot 
support reflinks.

Thanks!

~A


[1] https://lists.gnu.org/archive/html/coreutils/2021-06/msg00005.html that
[2] 
https://www.gnu.org/software/coreutils/manual/html_node/cp-invocation.html#cp-invocation

