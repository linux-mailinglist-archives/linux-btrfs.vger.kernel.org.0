Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3C74DDFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 21:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGJTNS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jul 2023 15:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjGJTNN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jul 2023 15:13:13 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061DD137;
        Mon, 10 Jul 2023 12:12:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A2925C006B;
        Mon, 10 Jul 2023 15:12:40 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 10 Jul 2023 15:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689016360; x=1689102760; bh=Hs
        syr6EMZRmpJVx1eAG3ugOBD1aZJaA1p9GC+p24zE0=; b=LgZteR+/17I2gy3B9Z
        j3vHDfXd1c/1OY2U9uaKlWLW1AY5h/3X/NO3TdOOl0FsNuXsw4kt4UvlISDM9piy
        PnHIFGMG1bG5blVp6jNePN1hURAb+W0wnTCIQTTxQPBAmx/Fn/NwBn298veRhvEN
        YW1CCS5DylGKFtT72dga6ob1fFTA9XNIuZwn12YYirtMbs1XZixhXOCGtUjnQT2p
        seajGiypVRJSDeQf7g1/1/4HJQoxCWMUwNpEtd8UNFpTdaF//7+ZAe5UZRZjiurJ
        LCGMBUR81w1fHKPfGh+kJHEjeXWY9VDIv5tK9E4RaazVcX4b1giyNv6JK1ZJtRet
        bPUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689016360; x=1689102760; bh=Hssyr6EMZRmpJ
        Vx1eAG3ugOBD1aZJaA1p9GC+p24zE0=; b=bjr4F+J0n14BcucsMzbPEY7f0sOKM
        fxB4oWoO4m1ysDqcvJwphW6AOpoBjEPXBH4NCGGXk+aeL5U+sPXiXufHpiDNRfIf
        c3hyxXKqZsTXKP6nbZ03ACfy5nm6XJ1dSrMqVQxLamf72JH0dU0RQtJXDCpHAKOH
        YPcoNisINVRsGI68hQB3VmqWUauMmYwWZCn649CpFVXguiwqFObnzTeXVNUqsxEQ
        rX0gmEpl/CbXKVCMGV1caENhzvlolMVtfGLos4yJXhdAyRj0MM/7BR/kYiBL7OUw
        4KbA30MOnUu6dTmz5Pd3qxkM4tekAqdWyvA0yHpqouh5VMU+21lyzfzow==
X-ME-Sender: <xms:J1isZAcBLUdrTLKOFwRDaojEr4ExP8CzZp9v7oVCvZmih9EXyy4rCg>
    <xme:J1isZCPWfwkgSkVLTxh2NEIcGOevEodT6UmCsNZm28ZldVvdIDdiVJ_ZXP_v5K6Wf
    WCDE-YIAaC9YrwAUJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:J1isZBj3dZ_qaZRAnf1LTXq4nA7fBOMvwjNtzHroOTu2nQTplUMdMg>
    <xmx:J1isZF8xPcDFkf3-zu4cFOdWLpwjf9T5PUAtA3KYNdMgJPsB7Xk7rQ>
    <xmx:J1isZMsjQfafqYdtUKeygQMBDuFATXCeDVrElRRpURFgkPTF6lDbdw>
    <xmx:KFisZKDVcJcBFn_Kd_aN0Z8BOOLUMY4YO0d4vmTPnn52Kanrpcf_aw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 96E561700090; Mon, 10 Jul 2023 15:12:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <47505d6f-a0a5-46ce-a3dc-78fda3256381@app.fastmail.com>
In-Reply-To: <20230710165506.GA30916@twin.jikos.cz>
References: <20230705140117.795478-1-arnd@kernel.org>
 <20230710165506.GA30916@twin.jikos.cz>
Date:   Mon, 10 Jul 2023 21:12:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "David Sterba" <dsterba@suse.cz>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Chris Mason" <clm@fb.com>, "Josef Bacik" <josef@toxicpanda.com>,
        "David Sterba" <dsterba@suse.com>,
        "Johannes Thumshirn" <johannes.thumshirn@wdc.com>,
        "Anand Jain" <anand.jain@oracle.com>,
        "Filipe Manana" <fdmanana@suse.com>, "Qu Wenruo" <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: avoid Wmaybe-uninitialized warnings
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 10, 2023, at 18:55, David Sterba wrote:
> On Wed, Jul 05, 2023 at 04:01:08PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The -Wmaybe-uninitialized warning option in gcc produces tons of false
>> positive warnings when KASAN is enabled, as that turns off some required
>> optimizations.
>
> Which version of gcc produces the warnings? I have KASAN enabled and
> don't see any warnings, with gcc 13. Making the warning conditional
> would effectively turn it off for me which means I can't catch the
> warnings early. We do get reports from various build bots with
> various arch/compiler combinations and fix the warnings.
>
> If there's a know minimum compiler version where there are no reports
> (or reasonably small nubmer to fix) then I'd rather make the condition
> bassed on that, neither on KASAN nor any similar feature for that matter.

As far as I can tell, this happens with every version of gcc.
What I think happens is that with any combination of compiler
flags and version, the code generation changes a little, so you
end up getting the warnings in different places, and one can
easily avoid them by adding fake initializers for a particular
configuration but not for other configurations.

If I run 100 randconfig builds with KASAN and btrfs force-enabled,
using gcc-13.1.0 like

for i in `seq 100` ; do
   make   -skj16 randconfig fs/btrfs/
done

building for arm32 (see below), I get maybe 20 failed builds, but
for x86 this is lower, maybe 2. I had attempted to work around
each one of the ones I saw, but ended up with a huge patch to
cover all architectures and compilers in random versions.

      Arnd

/home/arnd/arm-soc/fs/btrfs/scrub.c: In function 'scrub_simple_mirror.constprop':
/home/arnd/arm-soc/fs/btrfs/scrub.c:2014:16: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
 2014 |         return ret;
      |                ^~~
KCONFIG_SEED=0xFF336D86
KCONFIG_SEED=0x8B05C4B2
KCONFIG_SEED=0x64310838
KCONFIG_SEED=0x3DB885EC
KCONFIG_SEED=0x983AF756
KCONFIG_SEED=0xEC0D51EC
KCONFIG_SEED=0xB1B553E8
KCONFIG_SEED=0x98E3861
KCONFIG_SEED=0xAC9172F6
KCONFIG_SEED=0xA2325450
KCONFIG_SEED=0x20E308F6
KCONFIG_SEED=0xC238FBF0
KCONFIG_SEED=0x791A0953
KCONFIG_SEED=0x55CE08D2
KCONFIG_SEED=0x6653C680
KCONFIG_SEED=0x52503183
KCONFIG_SEED=0x4D293618
KCONFIG_SEED=0x558D9E5B
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xBFB8CB20
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xB104EEBA
KCONFIG_SEED=0x80695891
KCONFIG_SEED=0xD82997F0
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1741:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'sk' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1734:39: note: 'sk' declared here
 1734 |         struct btrfs_ioctl_search_key sk;
      |                                       ^~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search_v2' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1773:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search_v2':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1764:43: note: 'args' declared here
 1764 |         struct btrfs_ioctl_search_args_v2 args;
      |                                           ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_fslabel' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4127:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'label' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_fslabel':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4121:14: note: 'label' declared here
 4121 |         char label[BTRFS_LABEL_SIZE];
      |              ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_features' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4271:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'flags' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_features':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4263:42: note: 'flags' declared here
 4263 |         struct btrfs_ioctl_feature_flags flags[2];
      |                                          ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_space_info':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_encoded_write.constprop' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4488:7:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_encoded_write.constprop':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4448:44: note: 'args' declared here
 4448 |         struct btrfs_ioctl_encoded_io_args args;
      |                                            ^~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xAA4AD4E2
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1741:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'sk' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1734:39: note: 'sk' declared here
 1734 |         struct btrfs_ioctl_search_key sk;
      |                                       ^~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search_v2' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1773:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search_v2':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1764:43: note: 'args' declared here
 1764 |         struct btrfs_ioctl_search_args_v2 args;
      |                                           ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_fslabel' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4127:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'label' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_fslabel':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4121:14: note: 'label' declared here
 4121 |         char label[BTRFS_LABEL_SIZE];
      |              ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_features' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4271:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'flags' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_features':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4263:42: note: 'flags' declared here
 4263 |         struct btrfs_ioctl_feature_flags flags[2];
      |                                          ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_space_info':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_encoded_write.constprop' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4488:7:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_encoded_write.constprop':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4448:44: note: 'args' declared here
 4448 |         struct btrfs_ioctl_encoded_io_args args;
      |                                            ^~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x6DA7D48C
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x26CA5A79
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x2D2D44C
KCONFIG_SEED=0xD984DF1C
KCONFIG_SEED=0x9A330457
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1741:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'sk' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1734:39: note: 'sk' declared here
 1734 |         struct btrfs_ioctl_search_key sk;
      |                                       ^~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search_v2' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1773:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search_v2':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1764:43: note: 'args' declared here
 1764 |         struct btrfs_ioctl_search_args_v2 args;
      |                                           ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_fslabel' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4127:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'label' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_fslabel':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4121:14: note: 'label' declared here
 4121 |         char label[BTRFS_LABEL_SIZE];
      |              ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_encoded_write.constprop' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4488:7:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_encoded_write.constprop':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4448:44: note: 'args' declared here
 4448 |         struct btrfs_ioctl_encoded_io_args args;
      |                                            ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_features' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4271:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4677:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'flags' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4263:42: note: 'flags' declared here
 4263 |         struct btrfs_ioctl_feature_flags flags[2];
      |                                          ^~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xB1096B7E
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1741:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'sk' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1734:39: note: 'sk' declared here
 1734 |         struct btrfs_ioctl_search_key sk;
      |                                       ^~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search_v2' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1773:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search_v2':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1764:43: note: 'args' declared here
 1764 |         struct btrfs_ioctl_search_args_v2 args;
      |                                           ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_fslabel' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4127:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'label' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_fslabel':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4121:14: note: 'label' declared here
 4121 |         char label[BTRFS_LABEL_SIZE];
      |              ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_encoded_write.constprop' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4488:7:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_encoded_write.constprop':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4448:44: note: 'args' declared here
 4448 |         struct btrfs_ioctl_encoded_io_args args;
      |                                            ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_features' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4271:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4677:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'flags' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4263:42: note: 'flags' declared here
 4263 |         struct btrfs_ioctl_feature_flags flags[2];
      |                                          ^~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xAB63E698
KCONFIG_SEED=0xF60D4D80
KCONFIG_SEED=0x84787E6E
KCONFIG_SEED=0x39B76E26
KCONFIG_SEED=0x7266F10
KCONFIG_SEED=0xD08875AC
KCONFIG_SEED=0x4D8842C3
KCONFIG_SEED=0x29B7A4AC
KCONFIG_SEED=0xFED01A8F
KCONFIG_SEED=0x593CCD90
KCONFIG_SEED=0x9E8F768D
KCONFIG_SEED=0xB723335B
KCONFIG_SEED=0x6CE2500C
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xD26AE43C
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xF0EE3781
KCONFIG_SEED=0x2659EA00
KCONFIG_SEED=0x7A984178
KCONFIG_SEED=0x196A6EC8
KCONFIG_SEED=0xBBE97CCB
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xCA63D258
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xE360B828
KCONFIG_SEED=0x8BB52CA0
KCONFIG_SEED=0x9703EBEB
KCONFIG_SEED=0xC05C41F5
KCONFIG_SEED=0x8BBA3CC8
KCONFIG_SEED=0xCC046259
KCONFIG_SEED=0xED4A6408
KCONFIG_SEED=0x8194C34E
KCONFIG_SEED=0x3A029C2A
KCONFIG_SEED=0xAEC7F728
KCONFIG_SEED=0x6B0212AD
KCONFIG_SEED=0xA88C8291
KCONFIG_SEED=0x3F5C676C
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x2271B29B
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x6D7C92C0
KCONFIG_SEED=0xE127F39C
KCONFIG_SEED=0x30223BC0
KCONFIG_SEED=0xFB06665A
KCONFIG_SEED=0xF3AEAD98
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xF2F46C48
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xE6BC74C7
KCONFIG_SEED=0xC1487C18
KCONFIG_SEED=0xD4D4EAC8
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xE1003AAC
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remadeKCONFIG_SEED=0x85E79AC8
KCONFIG_SEED=0x94D3F039
KCONFIG_SEED=0x9D4C8E40
KCONFIG_SEED=0x60B769E3
KCONFIG_SEED=0xC386D86
KCONFIG_SEED=0x835F94A2
KCONFIG_SEED=0xC0F21885
KCONFIG_SEED=0xC50925AF
KCONFIG_SEED=0xFA8DDB2F
KCONFIG_SEED=0x56B76368
KCONFIG_SEED=0x394DADE7
KCONFIG_SEED=0xE11A07BB
KCONFIG_SEED=0xE2D409F8
KCONFIG_SEED=0x3B78F3C8
KCONFIG_SEED=0xF9ED4A5C
KCONFIG_SEED=0xE16D18FC
KCONFIG_SEED=0x97A0B953
KCONFIG_SEED=0xDBF867A6
KCONFIG_SEED=0xB9D4F056
KCONFIG_SEED=0x8C44E1A

WARNING: unmet direct dependencies detected for SM_GCC_8450
  Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
  Selected by [m]:
  - SM_VIDEOCC_8450 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]

WARNING: unmet direct dependencies detected for SM_GCC_8550
  Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
  Selected by [m]:
  - SM_VIDEOCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
KCONFIG_SEED=0xFF336D86
KCONFIG_SEED=0x8B05C4B2
KCONFIG_SEED=0x64310838
KCONFIG_SEED=0x3DB885EC
KCONFIG_SEED=0x983AF756
KCONFIG_SEED=0xEC0D51EC
KCONFIG_SEED=0xB1B553E8
KCONFIG_SEED=0x98E3861
KCONFIG_SEED=0xAC9172F6
KCONFIG_SEED=0xA2325450
KCONFIG_SEED=0x20E308F6
KCONFIG_SEED=0xC238FBF0
KCONFIG_SEED=0x791A0953
KCONFIG_SEED=0x55CE08D2
KCONFIG_SEED=0x6653C680
KCONFIG_SEED=0x52503183
KCONFIG_SEED=0x4D293618
KCONFIG_SEED=0x558D9E5B
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xBFB8CB20
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xB104EEBA
KCONFIG_SEED=0x80695891
KCONFIG_SEED=0xD82997F0
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1741:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'sk' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1734:39: note: 'sk' declared here
 1734 |         struct btrfs_ioctl_search_key sk;
      |                                       ^~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search_v2' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1773:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search_v2':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1764:43: note: 'args' declared here
 1764 |         struct btrfs_ioctl_search_args_v2 args;
      |                                           ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_fslabel' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4127:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'label' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_fslabel':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4121:14: note: 'label' declared here
 4121 |         char label[BTRFS_LABEL_SIZE];
      |              ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_features' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4271:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'flags' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_features':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4263:42: note: 'flags' declared here
 4263 |         struct btrfs_ioctl_feature_flags flags[2];
      |                                          ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_space_info':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_encoded_write.constprop' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4488:7:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_encoded_write.constprop':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4448:44: note: 'args' declared here
 4448 |         struct btrfs_ioctl_encoded_io_args args;
      |                                            ^~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xAA4AD4E2
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1741:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'sk' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1734:39: note: 'sk' declared here
 1734 |         struct btrfs_ioctl_search_key sk;
      |                                       ^~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search_v2' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1773:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search_v2':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1764:43: note: 'args' declared here
 1764 |         struct btrfs_ioctl_search_args_v2 args;
      |                                           ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_fslabel' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4127:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'label' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_fslabel':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4121:14: note: 'label' declared here
 4121 |         char label[BTRFS_LABEL_SIZE];
      |              ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_features' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4271:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'flags' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_features':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4263:42: note: 'flags' declared here
 4263 |         struct btrfs_ioctl_feature_flags flags[2];
      |                                          ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_space_info':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_encoded_write.constprop' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4488:7:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_encoded_write.constprop':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4448:44: note: 'args' declared here
 4448 |         struct btrfs_ioctl_encoded_io_args args;
      |                                            ^~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x6DA7D48C
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x26CA5A79
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x2D2D44C
KCONFIG_SEED=0xD984DF1C
KCONFIG_SEED=0x9A330457
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1741:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'sk' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1734:39: note: 'sk' declared here
 1734 |         struct btrfs_ioctl_search_key sk;
      |                                       ^~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search_v2' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1773:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search_v2':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1764:43: note: 'args' declared here
 1764 |         struct btrfs_ioctl_search_args_v2 args;
      |                                           ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_fslabel' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4127:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'label' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_fslabel':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4121:14: note: 'label' declared here
 4121 |         char label[BTRFS_LABEL_SIZE];
      |              ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_encoded_write.constprop' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4488:7:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_encoded_write.constprop':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4448:44: note: 'args' declared here
 4448 |         struct btrfs_ioctl_encoded_io_args args;
      |                                            ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_features' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4271:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4677:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'flags' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4263:42: note: 'flags' declared here
 4263 |         struct btrfs_ioctl_feature_flags flags[2];
      |                                          ^~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xB1096B7E
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1741:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'sk' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1734:39: note: 'sk' declared here
 1734 |         struct btrfs_ioctl_search_key sk;
      |                                       ^~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_tree_search_v2' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:1773:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_tree_search_v2':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:1764:43: note: 'args' declared here
 1764 |         struct btrfs_ioctl_search_args_v2 args;
      |                                           ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_fslabel' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4127:6:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'label' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_set_fslabel':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4121:14: note: 'label' declared here
 4121 |         char label[BTRFS_LABEL_SIZE];
      |              ^~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_encoded_write.constprop' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4488:7:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl_encoded_write.constprop':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4448:44: note: 'args' declared here
 4448 |         struct btrfs_ioctl_encoded_io_args args;
      |                                            ^~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_set_features' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4271:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4677:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'flags' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:4263:42: note: 'flags' declared here
 4263 |         struct btrfs_ioctl_feature_flags flags[2];
      |                                          ^~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xAB63E698
KCONFIG_SEED=0xF60D4D80
KCONFIG_SEED=0x84787E6E
KCONFIG_SEED=0x39B76E26
KCONFIG_SEED=0x7266F10
KCONFIG_SEED=0xD08875AC
KCONFIG_SEED=0x4D8842C3
KCONFIG_SEED=0x29B7A4AC
KCONFIG_SEED=0xFED01A8F
KCONFIG_SEED=0x593CCD90
KCONFIG_SEED=0x9E8F768D
KCONFIG_SEED=0xB723335B
KCONFIG_SEED=0x6CE2500C
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xD26AE43C
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xF0EE3781
KCONFIG_SEED=0x2659EA00
KCONFIG_SEED=0x7A984178
KCONFIG_SEED=0x196A6EC8
KCONFIG_SEED=0xBBE97CCB
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xCA63D258
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xE360B828
KCONFIG_SEED=0x8BB52CA0
KCONFIG_SEED=0x9703EBEB
KCONFIG_SEED=0xC05C41F5
KCONFIG_SEED=0x8BBA3CC8
KCONFIG_SEED=0xCC046259
KCONFIG_SEED=0xED4A6408
KCONFIG_SEED=0x8194C34E
KCONFIG_SEED=0x3A029C2A
KCONFIG_SEED=0xAEC7F728
KCONFIG_SEED=0x6B0212AD
KCONFIG_SEED=0xA88C8291
KCONFIG_SEED=0x3F5C676C
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x2271B29B
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x6D7C92C0
KCONFIG_SEED=0xE127F39C
KCONFIG_SEED=0x30223BC0
KCONFIG_SEED=0xFB06665A
KCONFIG_SEED=0xF3AEAD98
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xF2F46C48
In file included from /home/arnd/arm-soc/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /home/arnd/arm-soc/include/linux/compiler.h:246,
                 from /home/arnd/arm-soc/include/linux/export.h:5,
                 from /home/arnd/arm-soc/include/linux/linkage.h:7,
                 from /home/arnd/arm-soc/include/linux/kernel.h:17,
                 from /home/arnd/arm-soc/fs/btrfs/ioctl.c:6:
In function 'instrument_copy_from_user_before',
    inlined from '_copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:148:3,
    inlined from 'copy_from_user' at /home/arnd/arm-soc/include/linux/uaccess.h:183:7,
    inlined from 'btrfs_ioctl_space_info' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:2993:6,
    inlined from 'btrfs_ioctl' at /home/arnd/arm-soc/fs/btrfs/ioctl.c:4610:10:
/home/arnd/arm-soc/include/linux/kasan-checks.h:38:27: error: 'space_args' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
/home/arnd/arm-soc/include/linux/instrumented.h:129:9: note: in expansion of macro 'kasan_check_write'
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/home/arnd/arm-soc/include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/ioctl.c:2975:39: note: 'space_args' declared here
 2975 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/ioctl.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xE6BC74C7
KCONFIG_SEED=0xC1487C18
KCONFIG_SEED=0xD4D4EAC8
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0xE1003AAC
/home/arnd/arm-soc/fs/btrfs/tree-log.c: In function 'btrfs_log_prealloc_extents':
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4828:23: error: 'start_slot' may be used uninitialized [-Werror=maybe-uninitialized]
 4828 |                 ret = copy_items(trans, inode, dst_path, path,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4829 |                                  start_slot, ins_nr, 1, 0);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
/home/arnd/arm-soc/fs/btrfs/tree-log.c:4725:13: note: 'start_slot' was declared here
 4725 |         int start_slot;
      |             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/home/arnd/arm-soc/scripts/Makefile.build:243: fs/btrfs/tree-log.o] Error 1
make[6]: Target 'fs/btrfs/' not remade because of errors.
make[5]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs/btrfs] Error 2
make[5]: Target 'fs/btrfs/' not remade because of errors.
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:477: fs] Error 2
make[4]: Target 'fs/btrfs/' not remade because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x2BD778F8
KCONFIG_SEED=0xEC319E0E
KCONFIG_SEED=0xED473D40
KCONFIG_SEED=0x2F7A7070
KCONFIG_SEED=0xA58A4FCA
 because of errors.
make[3]: *** [/home/arnd/arm-soc/Makefile:1934: .] Error 2
make[3]: Target 'fs/btrfs/' not remade because of errors.
make[2]: *** [/home/arnd/arm-soc/Makefile:234: __sub-make] Error 2
make[2]: Target 'fs/btrfs/' not remade because of errors.
make[1]: *** [Makefile:234: __sub-make] Error 2
make[1]: Target 'fs/btrfs/' not remade because of errors.
make: *** [makefile:163: fs/btrfs/] Error 2
KCONFIG_SEED=0x2BD778F8
KCONFIG_SEED=0xEC319E0E
KCONFIG_SEED=0xED473D40
KCONFIG_SEED=0x2F7A7070
KCONFIG_SEED=0xA58A4FCA
