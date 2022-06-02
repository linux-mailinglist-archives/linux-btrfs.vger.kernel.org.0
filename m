Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C475753BA99
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbiFBOVQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 2 Jun 2022 10:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiFBOVP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 10:21:15 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0457243EF9
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:21:13 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwlhI-00056a-Ac by authid <merlin>; Thu, 02 Jun 2022 07:21:12 -0700
Date:   Thu, 2 Jun 2022 07:21:12 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220602142112.GQ22722@merlins.org>
References: <20220601225643.GJ22722@merlins.org>
 <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
 <20220601231008.GK22722@merlins.org>
 <CAEzrpqen1AXAYBq0M0LVzB8AVXMhAD_ve1Yj_+e=kPyCfdUiow@mail.gmail.com>
 <20220602000637.GL22722@merlins.org>
 <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
 <20220602015526.GM22722@merlins.org>
 <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
 <20220602021617.GP22722@merlins.org>
 <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
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

On Thu, Jun 02, 2022 at 10:07:27AM -0400, Josef Bacik wrote:
> > g chunk 15323969355776Inserting chunk 15325043097600Inserting chunk 15326116839424Inserting chunk 15327190581248Inserting chunk 15328264323072Inserting chunk 15329338064896Inserting chunk 15332559290368Inserting chunk 15333633032192Inserting chunk 15334706774016Inserting chunk 15355107868672Inserting chunk 15356181610496Inserting chunk 15357255352320Inserting chunk 15358329094144Inserting chunk 15359402835968Inserting chunk 15360476577792Inserting chunk 15361550319616Inserting chunk 15362624061440Inserting chunk 15363697803264Inserting chunk 15364771545088Inserting chunk 15365845286912Inserting chunk 15366919028736Inserting chunk 15395910057984Inserting chunk 15396983799808Inserting chunk 15400205025280Inserting chunk 15401278767104Inserting chunk 15402352508928Inserting chunk 15405573734400Inserting chunk 15408794959872Inserting chunk 15409868701696Inserting chunk 15410942443520Inserting chunk 15412016185344Inserting chunk 15413089927168Inserting chunk 15414163668992Inserting chunk 15415237410816Inserting chunk 15416311152640Inserting chunk 15417384894464Inserting chunk 15418458636288Inserting chunk 15419532378112Inserting chunk 15420606119936Inserting chunk 15421679861760Inserting chunk 15422753603584Inserting chunk 15423827345408Inserting chunk 15424901087232Inserting chunk 15425974829056Inserting chunk 15427048570880Inserting chunk 15428122312704Inserting chunk 15429196054528Inserting chunk 15430269796352Inserting chunk 15431343538176Inserting chunk 15432417280000Inserting chunk 15433491021824Inserting chunk 15434564763648Inserting chunk 15435638505472Inserting chunk 15436712247296Inserting chunk 15437785989120Inserting chunk 15438859730944Inserting chunk 15439933472768Inserting chunk 15441007214592Inserting chunk 15442080956416Inserting chunk 15443154698240Inserting chunk 15444228440064Inserting chunk 15445302181888Inserting chunk 15446375923712Inserting chunk 15447449665536Inserting chunk 15448523407360Inserting chunk 15449597149184Inserting chunk 15450670891008Inserting chunk 15451744632832Inserting chunk 15452818374656Inserting chunk 15453892116480Inserting chunk 15454965858304Inserting chunk 15456039600128Inserting chunk 15457113341952Inserting chunk 15458187083776Inserting chunk 15459260825600Inserting chunk 15460334567424Inserting chunk 15461408309248Inserting chunk 15462482051072Inserting chunk 15463555792896Inserting chunk 15464629534720Inserting chunk 15465703276544Inserting chunk 15466777018368Inserting chunk 15467850760192Inserting chunk 15468924502016Inserting chunk 15469998243840Inserting chunk 15471071985664Inserting chunk 15472145727488Inserting chunk 15473219469312Inserting chunk 15474293211136Inserting chunk 15475366952960Inserting
> 
> Woo we're in the transaction commit now boys, try again please.  Thanks,

Sure.

Note that you're missing some newlines in the output:

7296Inserting chunk 15437785989120Inserting chunk 15438859730944Inserting chunk 15439933472768Inserting chunk 15441007214592Inserting chunk 15442080956416Inserting chunk 15443154698240Inserting chunk 15444228440064Inserting chunk 15445302181888Inserting chunk 15446375923712Inserting chunk 15447449665536Inserting chunk 15448523407360Inserting chunk 15449597149184Inserting chunk 15450670891008Inserting chunk 15451744632832Inserting chunk 15452818374656Inserting chunk 15453892116480Inserting chunk 15454965858304Inserting chunk 15456039600128Inserting chunk 15457113341952Inserting chunk 15458187083776Inserting chunk 15459260825600Inserting chunk 15460334567424Inserting chunk 15461408309248Inserting chunk 15462482051072Inserting chunk 15463555792896Inserting chunk 15464629534720Inserting chunk 15465703276544Inserting chunk 15466777018368Inserting chunk 15467850760192Inserting chunk 15468924502016Inserting chunk 15469998243840Inserting chunk 15471071985664Inserting chunk 15472145727488Inserting chunk 15473219469312Inserting chunk 15474293211136Inserting chunk 15475366952960Inserting chkernel-shared/extent-tree.c:2417: alloc_reserved_tree_block: Assertion `sinfo` failed, value 0
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x2981a)[0x55555557d81a]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_run_delayed_refs+0x531)[0x555555583998]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_commit_transaction+0x3b)[0x5555555928a8]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_find_recover_chunks+0x594)[0x5555555e311d]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x83c87)[0x5555555d7c87]
/var/local/src/btrfs-progs-josefbacik/btrfs(handle_command_group+0x49)[0x55555556c17b]
/var/local/src/btrfs-progs-josefbacik/btrfs(main+0x94)[0x55555556c275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7ffff78617fd]
/var/local/src/btrfs-progs-josefbacik/btrfs(_start+0x2a)[0x55555556be1a]

Program received signal SIGABRT, Aborted.
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
