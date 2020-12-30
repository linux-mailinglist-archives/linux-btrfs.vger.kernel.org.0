Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A92E7B88
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Dec 2020 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL3RZT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Dec 2020 12:25:19 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:7043 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgL3RZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Dec 2020 12:25:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 55EDF41298;
        Wed, 30 Dec 2020 18:24:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.729
X-Spam-Level: 
X-Spam-Status: No, score=-2.729 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.829]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IUVMAfZQaqdX; Wed, 30 Dec 2020 18:24:21 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 660A83F719;
        Wed, 30 Dec 2020 18:24:20 +0100 (CET)
Received: from [192.168.0.10] (port=63732)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <system@lechevalier.se>)
        id 1kufCt-000Foc-Fk; Wed, 30 Dec 2020 18:24:19 +0100
Subject: Re: hierarchical, tree-like structure of snapshots
To:     john terragon <jterragon@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
From:   sys <system@lechevalier.se>
Message-ID: <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se>
Date:   Wed, 30 Dec 2020 18:24:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020-12-30 17:56, john terragon wrote:
> Hi.
> I would like to maintain a tree-like hierarchical structure of
> snapshots. Let me try to explain what I mean by that.
> 
> Let's say I have a btrfs fs with just one subvolume X, and let's say
> that a make a readonly snapshot Y of X. As far as I understand there
> is a parent-child relation between Y (the parent) and X the child.
> 
> Now let's say that after some time and modifications of X I do another
> snapshot Z of X. Now the "temporal" stucture would be Y-Z-X. So X is
> now the "child" of Z and Z is now the "child" of Y. The structure is a
> path which is a special case of a tree.
> 
> Now let's suppose that I want to start modify Y but I still want to be
> able to have a parent of Z which I might use as a point of reference
> for Z in a
> send to somewhere. That is I want to be able to still do a send -p Y Z
> to another btrfs filesystem where there is previously sent copy of Y
> (which, remember, as of this point has been readonly and I'm just now
> wanting to start to modify it).
> The only thing I think I can do would be to make a readonly snapshot
> Y1 of Y and make Y writeable (so that I can start modify it).

You should simply make a 'read-write' snapshot (Y-rw) of the 'read-only' 
snapshot (Y) that is part of your backup/send scheme. Do not modify 
read-only snapshots to be rw.


  At that
> point the structure would be
> 
> Y1-Y
>      \
>        Z-X
> 
> (yes my ascii art is atrocious...) which is a "proper" tree where Y1
> is the root with two children (Y and Z), Z has one child (X) and Y and
> X are leaves.
> Now, my question is, would Y1 still be usable in send -p Y1 Z, just
> like Y was before becoming writeable and being modified? I would say
> that Y1 would be just as good as the readonly original Y was as a
> parent for Z in a send. But maybe there is some implementation detail
> that escapes me and that prevents Y1 to be used as a perfect
> replacement for the original Y.
> I hope I was clear enough.
> Thanks
> John
> 
