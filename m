Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D9767D4CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjAZTAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 14:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjAZTAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 14:00:35 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592020680;
        Thu, 26 Jan 2023 11:00:34 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id e8so2124777qts.1;
        Thu, 26 Jan 2023 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i/VHXG1+CfC42VqMoe+RYyeq6fMh9yqnLGwKOPQQ1WI=;
        b=cUpquiKMd3Tn8zil+P4h27iDGIJey9y12f5MRSIF6/i9joeTTOYwKAumCzmg5s++p/
         LPsTP9m9feAL6MEDACxgrk2QLVZYh32TSS6aQwjB2bRYQhqJTnj75KJx8XzeJZpRZsfz
         x3S4uM4/TYE/4Y2yuH1ocl2OIgC4l6SLCWnF5JGyLh49cQsYA6qVNjD9/WlqIuRkjkdX
         LUb71jfPoY9lsYs4yYBVXhVrbNUhH+tZNklqwBB3dRQusKMkWg9kE8U6U3/JOGvOzIT8
         O49i4RUDOTgzT97u2f8FyWv/2gJx2cJK9UWCKerJSbwCV6mOHnIF9BBYx9CXK4OebWgu
         Atjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/VHXG1+CfC42VqMoe+RYyeq6fMh9yqnLGwKOPQQ1WI=;
        b=YaDtC8+t3ijtofHLpuKhVWPPFfzmVEro2zqH74lesPHgEaWlRifZoouyXa6+9/Sy4e
         JaqiDAFTyt23UUOAOUhVXgNGvsSuIXwB9Chp+7OZE13zUsJFhzyqm1UvShz+0diNkRh/
         83XdMhFN6KTZ4e1cqdm0vmt2HQcczTnynJgL5Dure+NsksGIX7OkqPMD4zU9JDfBf1EA
         ceb4lXtj+fzaoPkcs4aoJSzy9/9Usj4qsrt64PILp30zgTo7bA9XaslPSjqQzfui/GYX
         gv9jaM0fti+HcsDqwYWxHrXcsOiBbMIAZVxpFjDf6pERd2/iCJUtBBctUfXYOhRDqvkY
         ZtOg==
X-Gm-Message-State: AFqh2krZIqRvVPpnzeYsspNEQcXOXiIP2ipepJhRWOAtnpg57EkkAjZD
        troG8PBh73HaVoKHjDjEXcqD0ObbEaI=
X-Google-Smtp-Source: AMrXdXuK35nYcjMs4ltMCt0HdLHQOs4QjUhNx25y6m6OyRw8WLRolTB7ZkgoHmndz6XrUaZZ+PG5QQ==
X-Received: by 2002:ac8:7cb2:0:b0:3b6:3e4f:f876 with SMTP id z18-20020ac87cb2000000b003b63e4ff876mr48341780qtv.18.1674759633060;
        Thu, 26 Jan 2023 11:00:33 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q26-20020ac8411a000000b003b34650039bsm1199679qtl.76.2023.01.26.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:00:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8144E27C0054;
        Thu, 26 Jan 2023 14:00:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 14:00:30 -0500
X-ME-Sender: <xms:zc3SY7GHo6_7Ydb3UoLY2kqUtpbwh2R9smiulfSm0MAry48QdEyXZA>
    <xme:zc3SY4Xoq5GrSWYw6D9lP3lH-1bx0ctChOOMox4CrGkhCT6VKcec1bD1xnK3arXe9
    sJKUDTxRlgh29ZiSA>
X-ME-Received: <xmr:zc3SY9LWFSH3zNOxOUxkwHfQxW6UGcrwE0uzsW40URciNcoiM57CPB0LtRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:zc3SY5GPyB-ndnydMkhEJg3MVuXsIjGhZY0vAG0k8EGDXzL4tEregw>
    <xmx:zc3SYxUrUQ2Ypqsb64DMvuaLaboG1Kcs6HRWNzjpx3hW3d3aObHEGA>
    <xmx:zc3SY0PShgZ3VGjFZDNm_yDs8XLZIddyeY-cHMYB9ZWQdckIHuz3BA>
    <xmx:zs3SY5S21C2kIil485e9YHpQRm7VWq6sLg1a2nE3O24xEkjA4pAwGA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 14:00:29 -0500 (EST)
Date:   Thu, 26 Jan 2023 10:59:44 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, dsterba@suse.cz,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <Y9LNoDtOK4nun968@boqun-archlinux>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <017f7b9e-323c-f9aa-12fa-9c9a16dabd35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <017f7b9e-323c-f9aa-12fa-9c9a16dabd35@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 26, 2023 at 01:30:34PM -0500, Waiman Long wrote:
> On 1/26/23 12:38, Boqun Feng wrote:
> > [Cc lock folks]
> > 
> > On Thu, Jan 26, 2023 at 02:47:42PM +0500, Mikhail Gavrilov wrote:
> > > On Wed, Jan 25, 2023 at 10:21 PM David Sterba <dsterba@suse.cz> wrote:
> > > > On Wed, Jan 25, 2023 at 01:27:48AM +0500, Mikhail Gavrilov wrote:
> > > > > On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrote:
> > > > > > On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
> > > > > > > Hi guys.
> > > > > > > Always with intensive writing on a btrfs volume, the message "BUG:
> > > > > > > MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
> > > > > > Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
> > > > > > tends to work.
> > > > > Hi,
> > > > > Today I was able to get the message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
> > > > > low!" again even with LOCKDEP_CHAINS_BITS=18 and kernel 6.2-rc5.
> > > > > 
> > > > > ❯ cat /boot/config-`uname -r` | grep LOCKDEP_CHAINS_BITS
> > > > > CONFIG_LOCKDEP_CHAINS_BITS=18
> > > > > 
> > > > > [88685.088099] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > > > > [88685.088124] turning off the locking correctness validator.
> > > > > [88685.088133] Please attach the output of /proc/lock_stat to the bug report
> > > > > [88685.088142] CPU: 14 PID: 1749746 Comm: mv Tainted: G        W    L
> > > > >    -------  ---  6.2.0-0.rc5.20230123git2475bf0250de.38.fc38.x86_64 #1
> > > > > [88685.088154] Hardware name: System manufacturer System Product
> > > > > Name/ROG STRIX X570-I GAMING, BIOS 4408 10/28/2022
> > > > > 
> > > > > What's next? Increase this value to 19?
> > > > Yes, though increasing the value is a workaround so you may see the
> > > > warning again.
> > > Is there any sense in this WARNING if we would ignore it and every
> > > time increase the threshold value?
> > Lockdep uses static allocated array to track lock holdings chains to
> > avoid dynmaic memory allocation in its own code. So if you see the
> > warning it means your test has more combination of lock holdings than
> > the array can record. In other words, you reach the resource limitation,
> > and in that sense it makes sense to just ignore it and increase the
> > value: you want to give lockdep enough resource to work, right?
> > 
> > > May Be set 99 right away? Or remove such a check condition?
> > That requires having 2^99 * 5 * sizeof(u16) memory for lock holding
> > chains array..
> 
> Note that every increment of LOCKDEP_CHAINS_BITS double the storage space.
> With 99, that will likely exceed the total amount of memory you have in your
> system.
> 
> Boqun, where does the 5 figure come from. It is just a simple u16 array of

	#define MAX_LOCKDEP_CHAINS_BITS	CONFIG_LOCKDEP_CHAINS_BITS
	#define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)

	#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)

I think the last one means we think the average length of a lock chain
is 5, in other words, in average, a task hold at most 5 locks. I don't
know where the 5 came from either, but it's there ;-)

Regards,
Boqun

> size MAX_LOCKDEP_CHAIN_HLOCKS. The chain_hlocks array stores the lock chains
> that show up in the lockdep splats and in the /proc/lockdep* files. Each
> chain is variable size. As we add new lock into the chain, we have to
> repeatedly deallocate and reallocate a larger chain buffer. That will cause
> fragmentation in the chain_hlocks[]. So if we have a very long lock chain,
> the allocation may fail because the largest free block is smaller than the
> requested chain length. There may be enough free space in chain_hlocks, but
> it is just too fragmented to be useful.
> 
> Maybe we should figure out a better way to handle this fragmentation. In the
> mean time, the easiest way forward is just to increase the
> LOCKDEP_CHAINS_BITS by 1.
> 
> > 
> > However, a few other options we can try in lockdep are:
> > 
> > *	warn but not turn off the lockdep: the lock holding chain is
> > 	only a cache for what lock holding combination lockdep has ever
> > 	see, we also record the dependency in the graph. Without the
> > 	lock holding chain, lockdep can still work but just slower.
> > 
> > *	allow dynmaic memory allocation in lockdep: I think this might
> > 	be OK since we have lockdep_recursion to avoid lockdep code ->
> > 	mm code -> lockdep code -> mm code ... deadlock. But maybe I'm
> > 	missing something. And even we allow it, the use of memory
> > 	doesn't change, you will still need that amout of memory to
> > 	track lock holding chains.
> 
> It is not just the issue of calling the memory allocator. There is also the
> issue of copying data from old chain_hlocks to new one while the old one may
> be updated during the copying process unless we can freeze everything else.
> 
> Cheers,
> Longman
> 
