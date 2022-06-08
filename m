Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34898543EB7
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiFHViy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiFHViu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:38:50 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877FC156B76
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 14:38:46 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nz3O1-0004LX-Sx by authid <merlin>; Wed, 08 Jun 2022 14:38:45 -0700
Date:   Wed, 8 Jun 2022 14:38:45 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220608213845.GH22722@merlins.org>
References: <20220607233734.GA22722@merlins.org>
 <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
 <20220608000700.GB22722@merlins.org>
 <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
 <20220608004241.GC22722@merlins.org>
 <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
 <20220608021245.GD22722@merlins.org>
 <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
 <20220608213030.GG22722@merlins.org>
 <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 08, 2022 at 05:33:42PM -0400, Josef Bacik wrote:
> 
> Just check, no --repair.  I want to make sure the only thing that is
> missing is the corresponding device extents for the chunks we
> recovered.  I'm going to start writing the code to do that now, but if
> there's any errors other than missing device extents then we need to
> figure out what those problems are and what to do about them.  Thanks,

woah, it ran in less than 1 minute, that's amazing (I remember when it
took days)

Partial output

[1/7] checking root items
checksum verify failed on 15645959372800 wanted 0x847c08bf found 0x17a9e2f1
checksum verify failed on 15645959389184 wanted 0x3cc757a7 found 0x3b4eff03
checksum verify failed on 15645681451008 wanted 0x7516a3d9 found 0x97f7437d
checksum verify failed on 15646003970048 wanted 0xf18cc579 found 0x1bc64584
checksum verify failed on 15645867720704 wanted 0x14cc427a found 0x9f516106
checksum verify failed on 15645529604096 wanted 0xd11e24d5 found 0x8d01bc00
checksum verify failed on 15645781344256 wanted 0xb81e3df4 found 0xb5c70846
checksum verify failed on 15645959356416 wanted 0x2fa8537e found 0x90ac1f4e
(...)
[2/7] checking extents
checksum verify failed on 15645930487808 wanted 0xced0911a found 0x7124e4f9
Chunk[256, 228, 11106814787584] stripe[1, 11121855561728] is not found in dev extent
Chunk[256, 228, 11108962271232] stripe[1, 11124003045376] is not found in dev extent
Chunk[256, 228, 11110036013056] stripe[1, 11125076787200] is not found in dev extent
Chunk[256, 228, 11111109754880] stripe[1, 11126150529024] is not found in dev extent
Chunk[256, 228, 11112183496704] stripe[1, 11127224270848] is not found in dev extent
Chunk[256, 228, 11113257238528] stripe[1, 11128298012672] is not found in dev extent
Chunk[256, 228, 11114330980352] stripe[1, 11129371754496] is not found in dev extent
Chunk[256, 228, 11115404722176] stripe[1, 11130445496320] is not found in dev extent
Chunk[256, 228, 11116478464000] stripe[1, 11131519238144] is not found in dev extent
Chunk[256, 228, 11118625947648] stripe[1, 11133666721792] is not found in dev extent
Chunk[256, 228, 11119699689472] stripe[1, 11134740463616] is not found in dev extent
(...)
Chunk[256, 228, 15931707228160] stripe[1, 14489109921792] is not found in dev extent
Chunk[256, 228, 15932780969984] stripe[1, 14490183663616] is not found in dev extent
Chunk[256, 228, 15933854711808] stripe[1, 14496626114560] is not found in dev extent
Block group[20971520, 8388608] (flags = 34) didn't find the relative chunk.
Device extent[1, 709781094400, 1073741824] didn't find the relative chunk.
Device extent[1, 710854836224, 1073741824] didn't find the relative chunk.
Device extent[1, 711928578048, 1073741824] didn't find the relative chunk.
Device extent[1, 713002319872, 1073741824] didn't find the relative chunk.
(...)
Device extent[1, 14951892647936, 1073741824] didn't find its device.
Device extent[1, 14952966389760, 1073741824] didn't find its device.
Device extent[1, 14954040131584, 1073741824] didn't find its device.
Device extent[1, 14955113873408, 1073741824] didn't find its device.
Device extent[1, 14956187615232, 1073741824] didn't find its device.
Device extent[1, 14957261357056, 1073741824] didn't find its device.
Device extent[1, 14958335098880, 1073741824] didn't find its device.
Device extent[1, 14959408840704, 1073741824] didn't find its device.
Device extent[1, 14960482582528, 1073741824] didn't find its device.
Device extent[1, 14961556324352, 1073741824] didn't find its device.
Device extent[1, 14962630066176, 1073741824] didn't find its device.
Device extent[1, 14963703808000, 1073741824] didn't find its device.
Device extent[1, 14964777549824, 1073741824] didn't find its device.
Device extent[1, 14965851291648, 1073741824] didn't find its device.
Device extent[1, 14966925033472, 1073741824] didn't find its device.
Device extent[1, 14967998775296, 1073741824] didn't find its device.
Device extent[1, 14969072517120, 1073741824] didn't find its device.
Device extent[1, 14970146258944, 1073741824] didn't find its device.
Device extent[1, 14971220000768, 1073741824] didn't find its device.
Device extent[1, 14972293742592, 1073741824] didn't find its device.
Device extent[1, 14973367484416, 1073741824] didn't find its device.
Device extent[1, 14974441226240, 1073741824] didn't find its device.
Device extent[1, 14975514968064, 1073741824] didn't find its device.
Device extent[1, 14976588709888, 1073741824] didn't find its device.
Device extent[1, 14977662451712, 1073741824] didn't find its device.
Device extent[1, 14978736193536, 1073741824] didn't find its device.
Device extent[1, 14979809935360, 1073741824] didn't find its device.
Device extent[1, 14980883677184, 1073741824] didn't find its device.
Device extent[1, 14981957419008, 1073741824] didn't find its device.
Device extent[1, 14983031160832, 1073741824] didn't find its device.
Device extent[1, 14984104902656, 1073741824] didn't find its device.
Device extent[1, 14985178644480, 1073741824] didn't find its device.
Device extent[1, 14986252386304, 1073741824] didn't find its device.
Device extent[1, 14987326128128, 1073741824] didn't find its device.
Device extent[1, 14988399869952, 1073741824] didn't find its device.
Device extent[1, 14989473611776, 1073741824] didn't find its device.
Device extent[1, 14990547353600, 1073741824] didn't find its device.
Device extent[1, 14991621095424, 1073741824] didn't find its device.
Device extent[1, 14992694837248, 1073741824] didn't find its device.
Device extent[1, 14993768579072, 1073741824] didn't find its device.
Device extent[1, 14994842320896, 1073741824] didn't find its device.
Device extent[1, 14995916062720, 1073741824] didn't find its device.
Device extent[1, 14996989804544, 1073741824] didn't find its device.
Device extent[1, 14998063546368, 1073741824] didn't find its device.
Device extent[1, 14999137288192, 1073741824] didn't find its device.
Device extent[1, 15000211030016, 1073741824] didn't find its device.
Device extent[1, 15001284771840, 1073741824] didn't find its device.
Device extent[1, 15002358513664, 1073741824] didn't find its device.
Device extent[1, 15003432255488, 1073741824] didn't find its device.
Device extent[1, 15004505997312, 1073741824] didn't find its device.
Device extent[1, 15005579739136, 1073741824] didn't find its device.
Device extent[1, 15006653480960, 1073741824] didn't find its device.
Device extent[1, 15007727222784, 1073741824] didn't find its device.
Device extent[1, 15008800964608, 1073741824] didn't find its device.
Device extent[1, 15009874706432, 1073741824] didn't find its device.
Device extent[1, 15010948448256, 1073741824] didn't find its device.
Device extent[1, 15012022190080, 1073741824] didn't find its device.
Device extent[1, 15013095931904, 1073741824] didn't find its device.
Device extent[1, 15014169673728, 1073741824] didn't find its device.
        unresolved ref dir 55138 index 46 namelen 26 name foo filetype 1 errors 5, no dir item, no inode ref 
root 161199 inode 55184 errors 1, no inode item
        unresolved ref dir 55138 index 47 namelen 47 name foo filetype 1 errors 5, no dir item, no inode ref
root 161199 inode 55185 errors 1, no inode item 
        unresolved ref dir 55138 index 48 namelen 45 name foo filetype 1 errors 5, no dir item, no inode ref
root 161199 inode 55186 errors 1, no inode item 
        unresolved ref dir 55138 index 49 namelen 42 name foo filetype 1 errors 5, no dir item, no inode ref
root 161199 inode 55187 errors 1, no inode item 
        unresolved ref dir 55138 index 50 namelen 51 name foo filetype 1 errors 5, no dir item, no inode ref
root 161199 inode 55188 errors 1, no inode item
        unresolved ref dir 55138 index 51 namelen 47 name foo filetype 1 errors 5, no dir item, no inode ref
root 161199 inode 55403 errors 2500, file extent discount, nbytes wrong, link count wrong
root 161889 inode 70800 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 33 namelen 15 name foo filetype 2 errors 4, no inode ref
root 161889 inode 71665 errors 2001, no inode item, link count wrong 
        unresolved ref dir 3327 index 35 namelen 13 name foo filetype 2 errors 4, no inode ref
root 161889 inode 71860 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 36 namelen 41 name foo filetype 2 errors 4, no inode ref
root 161889 inode 71905 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 37 namelen 69 name foo filetype 2 errors 4, no inode ref
root 161889 inode 72375 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 38 namelen 14 name foo filetype 2 errors 4, no inode ref 
root 161889 inode 72543 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 39 namelen 12 name foo filetype 2 errors 4, no inode ref
root 161889 inode 72593 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 40 namelen 4 name foo filetype 2 errors 4, no inode ref
root 161889 inode 72723 errors 2001, no inode item, link count wrong 
        unresolved ref dir 3327 index 45 namelen 15 name foo filetype 2 errors 4, no inode ref
root 161889 inode 72724 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 46 namelen 29 name foo filetype 2 errors 4, no inode ref
root 161889 inode 72738 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 47 namelen 25 name foo filetype 2 errors 4, no inode ref 
root 161889 inode 72779 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 48 namelen 33 name foo filetype 1 errors 4, no inode ref
root 161889 inode 72780 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 49 namelen 33 name foo filetype 1 errors 4, no inode ref
root 161889 inode 72781 errors 2001, no inode item, link count wrong 
        unresolved ref dir 3327 index 50 namelen 33 name foo filetype 1 errors 4, no inode ref
root 161889 inode 72782 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 51 namelen 21 name foo filetype 1 errors 4, no inode ref
root 161889 inode 72783 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 52 namelen 40 name foo filetype 1 errors 4, no inode ref 
root 161889 inode 72784 errors 2001, no inode item, link count wrong
        unresolved ref dir 3327 index 53 namelen 40 name foo filetype 1 errors 4, no inode ref
root 162628 root dir 256 not found
root 162628 inode 49389 errors 2500, file extent discount, nbytes wrong, link count wrong
index, no inode ref
root 163302 inode 11222 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 43 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11232 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 75 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11233 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 41 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11239 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 82 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11240 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 51 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11246 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 56 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11249 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 51 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11266 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 53 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11271 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 55 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11275 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 42 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11276 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 87 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11278 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 48 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11285 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 58 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11293 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 51 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11296 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 41 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11301 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 55 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11306 errors 2001, no inode item, link count wrong
        unresolved ref dir 11179 index 0 namelen 49 name foo filetype 1 errors 6, no dir index, no inode ref
root 163302 inode 11307 errors 2001, no inode item, link count wrong 
        unresolved ref dir 11179 index 0 namelen 60 name foo filetype 1 errorFound file extent holes:
        start: 0, len: 260874240
root 164623 inode 3682 errors 500, file extent discount, nbytes wrong
Found file extent holes:
        start: 0, len: 103227392
root 164623 inode 3683 errors 500, file extent discount, nbytes wrong
Found file extent holes:
        start: 0, len: 58925056
root 164623 inode 3684 errors 500, file extent discount, nbytes wrong
Found file extent holes:
        start: 0, len: 22671360
root 164623 inode 3685 errors 500, file extent discount, nbytes wrong
Found file extent holes:
        start: 0, len: 55967744
root 164623 inode 3686 errors 500, file extent discount, nbytes wrong
Found file extent holes:
        start: 0, len: 164442112
        unresolved ref dir 3676 index 11 namelen 62 name foo filetype 1 errroot 164629 inode 859 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 65 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 860 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 63 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 861 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 66 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 862 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 59 name foo filetype 1 errors 6, no dir index, no inode ref 
root 164629 inode 864 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 72 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 865 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 58 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 866 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 88 name foo filetype 7 errors 6, no dir index, no inode ref
root 164629 inode 867 errors 2001, no inode item, link count wrong 
        unresolved ref dir 842 index 0 namelen 57 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 868 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 70 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 872 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 101 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 873 errors 2001, no inode item, link count wrong 
        unresolved ref dir 842 index 0 namelen 80 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 874 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 69 name foo filetype 1 errors 6, no dir index, no inode ref 
root 164629 inode 875 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 79 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 876 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 51 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 877 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 95 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 878 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 87 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 879 errors 2001, no inode item, link count wrong 
        unresolved ref dir 842 index 0 namelen 75 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 880 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 44 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 881 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 67 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 884 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 70 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 885 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 84 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 887 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 87 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 888 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 74 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 890 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 80 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 891 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 87 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 892 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 91 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 904 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 79 name foo filetype 1 errors 6, no dir index, no inode ref 
root 164629 inode 905 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 101 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 907 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 62 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 909 errors 2001, no inode item, link count wrong 
        unresolved ref dir 842 index 0 namelen 70 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 910 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 74 name foo filetype 1 errors 6, no dir index, no inode ref 
root 164629 inode 911 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 63 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 912 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 84 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 913 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 93 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 914 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 68 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 917 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 79 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 918 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 89 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 921 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 87 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 922 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 72 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 923 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 87 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 925 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 80 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 926 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 70 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 927 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 70 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 928 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 72 name foo filetype 7 errors 6, no dir index, no inode ref
root 164629 inode 1047 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 86 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 1050 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 88 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 1051 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 81 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 1052 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 91 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 1053 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 57 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 1054 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 67 name foo filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 1055 errors 2001, no inode item, link count wrong
        unresolved ref dir 842 index 0 namelen 78 name foo froot 164629 inode 17822 errors 2001, no inode item, link count wrong
        unresolved ref dir 791 index 144 namelen 58 name foo filetype 1 errors 4, no inode ref
root 164629 inode 17824 errors 1, no inode item
        unresolved ref dir 791 index 145 namelen 47 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17893 errors 1, no inode item
root 164629 inode 17894 errors 2500, file extent discount, nbytes wrong, link count wrong 
Found file extent holes:
        start: 0, len: 9650176
        unresolved ref dir 17893 index 2 namelen 50 name foo filetype 0 errors 3, no dir item, no dir index
root 164629 inode 17895 errors 2500, file extent discount, nbytes wrong, link count wrong
Found file extent holes: 
        start: 0, len: 64696320
root 164629 inode 17896 errors 1, no inode item
        unresolved ref dir 17893 index 4 namelen 57 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17897 errors 1, no inode item
        unresolved ref dir 17893 index 5 namelen 26 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17898 errors 1, no inode item
        unresolved ref dir 17893 index 6 namelen 31 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17899 errors 1, no inode item
        unresolved ref dir 17893 index 7 namelen 46 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17900 errors 1, no inode item
        unresolved ref dir 17893 index 8 namelen 119 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17901 errors 1, no inode item
        unresolved ref dir 17893 index 9 namelen 66 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17902 errors 1, no inode item
        unresolved ref dir 17893 index 10 namelen 44 name foo filetype 1 errors 5, no dir item, no inode ref 
root 164629 inode 17903 errors 1, no inode item
        unresolved ref dir 17893 index 11 namelen 111 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17904 errors 1, no inode item
        unresolved ref dir 17893 index 12 namelen 34 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17905 errors 1, no inode item
        unresolved ref dir 17893 index 13 namelen 34 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17906 errors 1, no inode item
        unresolved ref dir 17893 index 14 namelen 41 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17907 errors 1, no inode item
        unresolved ref dir 17893 index 15 namelen 59 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17908 errors 1, no inode item
        unresolved ref dir 17893 index 16 namelen 47 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17909 errors 1, no inode item 
        unresolved ref dir 17893 index 17 namelen 25 name foo filetype 1 errors 5, no dir item, no inode ref
root 164629 inode 17910 errors 1, no inode item
root 164823 inode 25244 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 34 namelen 9 name foo filetype 2 errors 4, no inode ref
root 164823 inode 25246 errors 2001, no inode item, link count wrong 
        unresolved ref dir 842 index 296 namelen 70 name foo filetype 1 errors 4, no inode ref
root 164823 inode 27724 errors 2001, no inode item, link count wrong 
        unresolved ref dir 3654 index 35 namelen 5 name foo filetype 2 errors 4, no inode ref
root 164823 inode 34022 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 39 namelen 3 name foo filetype 2 errors 4, no inode ref 
root 164823 inode 34023 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 40 namelen 3 name foo filetype 2 errors 4, no inode ref
root 164823 inode 34454 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 60 namelen 11 name foo filetype 1 errors 4, no inode ref
root 164823 inode 34455 errors 2001, no inode item, link count wrong 
        unresolved ref dir 3654 index 62 namelen 6 name foo filetype 1 errors 4, no inode ref
root 164823 inode 34471 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 76 namelen 11 name foo filetype 1 errors 4, no inode ref 
root 164823 inode 34480 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 86 namelen 6 name foo filetype 1 errors 4, no inode ref
root 164823 inode 34482 errors 2001, no inode item, link count wrong 
        unresolved ref dir 3654 index 87 namelen 6 name foo filetype 1 errors 4, no inode ref
root 164823 inode 34508 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 98 namelen 11 name foo filetype 1 errors 4, no inode ref 
root 164823 inode 34511 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 102 namelen 6 name foo filetype 1 errors 4, no inode ref
root 164823 inode 34512 errors 2001, no inode item, link count wrong 
        unresolved ref dir 3654 index 103 namelen 11 name foo filetype 1 errors 4, no inode ref
root 164823 inode 35040 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 159 namelen 11 name foo filetype 1 errors 4, no inode ref 
root 164823 inode 35142 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 209 namelen 6 name foo filetype 1 errors 4, no inode ref
root 164823 inode 35200 errors 1, no inode item 
        unresolved ref dir 791 index 156 namelen 41 name foo filetype 1 errors 5, no dir item, no inode ref
root 164823 inode 35232 errors 2001, no inode item, link count wrong
        unresolved ref dir 3676 index 24 namelen 45 name foo filetype 1 errors 4, no inode ref
root 164823 inode 35241 errors 2001, no inode item, link count wrong
        unresolved ref dir 3676 index 25 namelen 62 name foo filetype 1 errors 4, no inode ref
root 164823 inode 36759 errors 1, no inode item
        unresolved ref dir 791 index 157 namelen 44 name foo filetype 1 errors 5, no dir item, no inode ref
root 164823 inode 37194 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 213 namelen 3 name foo filetype 2 errors 4, no inode ref
root 164823 inode 38289 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 212 namelen 1 name foo filetype 7 errors 4, no inode ref
root 164823 inode 39940 errors 2001, no inode item, link count wrong
        unresolved ref dir 3676 index 27 namelen 103 name foo filetype 1 errors 4, no inode ref
root 164823 inode 39950 errors 2001, no inode item, link count wrong
        unresolved ref dir 3676 index 26 namelen 117 name foo filetype 1 errors 4, no inode ref
root 164823 inode 39951 errors 2001, no inode item, link count wrong
        unresolved ref dir 3676 index 28 namelen 66 name foo filetype 1 errors 4, no inode ref
root 164823 inode 69105 errors 1, no inode item
        unresolved ref dir 68739 index 151 namelen 66 name foo filetype 0 errors 3, no dir item, no dir index
root 164823 inode 69135 errors 2000, link count wrong
        unresolved ref dir 256 index 68892 namelen 4 name foo filetype 0 errors 3, no dir item, no dir index
root 164823 inode 69136 errors 2200, dir isize wrong, link count wrong
        unresolved ref dir 1938 index 4 namelen 40 name foo filetype 0 errors 3, no dir item, no dir index
root 164823 inode 69252 errors 2001, no inode item, link count wrong
        unresolved ref dir 69136 index 0 namelen 31 name foo filetype 2 errors 6, no dir index, no inode ref
root 164823 inode 74108 errors 2001, no inode item, link count wrong
        unresolved ref dir 3280 index 12 namelen 44 name foo filetype 1 errors 4, no inode ref
root 164823 inode 74132 errors 2001, no inode item, link count wrong
        unresolved ref dir 256 index 19071 namelen 4 name foo filetype 2 errors 4, no inode ref
root 164823 inode 74193 errors 2001, no inode item, link count wrong
        unresolved ref dir 3654 index 214 namelen 4 name foo filetype 2 errors 4, no inode ref
root 164823 inode 74838 errors 2001, no inode item, link count wrong
        unresolved ref dir 3280 index 13 namelen 21 name foo filetype 2 errors 4, no inode ref
root 164823 inode 76221 errors 2001, no inode item, link count wrong
        unresolved ref dir 791 index 161 namelen 41 name foo filetype 1 errors 4, no inode ref
root 164823 inode 76328 errors 2001, no inode item, link count wrong
        unresolved ref dir 3280 index 16 namelen 88 name foo filetype 1 errors 4, no inode ref
root 164823 inode 76329 errors 2001, no inode item, link count wrong
        unresolved ref dir 3280 index 17 namelen 88 name foo filetype 1 errors 4, no inode ref
ERROR: errors found in fs roots
found 21912809472 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 5373952
total fs tree bytes: 3424256
total extent tree bytes: 573440
btree space waste bytes: 1834949
file data blocks allocated: 33614336000
 referenced 33612742656

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
