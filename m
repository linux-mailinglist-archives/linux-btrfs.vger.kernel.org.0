Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880E6778C2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 12:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjHKKnd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 06:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbjHKKnP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 06:43:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3670FE2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691750565; x=1692355365; i=quwenruo.btrfs@gmx.com;
 bh=l1IqNSlZIl/4upWInjgCaUyqj/unYJqKQGAcIjks2rU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hasSLfGtWowiKLdAOd0IIsz3U5ThfFpRzGTjZ1qfOx91eYq4LU9MHWU5PT9sZsmS7BNbtp6
 AHIL0nhYI8g1T4o5OrMZRLB2IGX32DOEynzasMeD7hVhixVqERT9oN7D7pclpRRJG5AI5gzPK
 n3Ku/BIRxandpYCprAPDD9fRKt4gol0yAQYzpwPmfASLAWZDA0p05Yxk4zSHNqnL9b9ZjOS/t
 z1PI8NqiFY8z/DPq5EBRUz92UD53AZ0ppXvvJaCttH4XC3pqmAnPWMLHTQVwVwZGYoInEcHZ1
 p/IMNpOgtQeeNibPi/zb1IxWTHA/Bv9o7TbY8YBJuWnEyMG6LJ9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp9Y-1qIPai2Hwy-00YAEX; Fri, 11
 Aug 2023 12:42:45 +0200
Message-ID: <92674fc4-468d-4291-9aaa-6be62e9088c2@gmx.com>
Date:   Fri, 11 Aug 2023 18:42:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: remove v0 extent handling
To:     kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
References: <6258b0bf5e41e52ca0e163e34650d186363628c6.1691740017.git.wqu@suse.com>
 <202308111815.mJwoiury-lkp@intel.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <202308111815.mJwoiury-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hJ//i9is0PCBlka465h8cjxSmGIF55n91xUCXEXsPGud8y0hoI6
 AgMqhoSiZn7cLtu87UWpQNT61Rj7iT4NwG7jO7nrNvUJpZzRV5KA+9CZtu9zfffTCBU4z3S
 L3oBmIDImFX4ScXow/RwQCvLTsW3DW/cOnWuJjCBC6+mSa76hqTBSm/LNdiblQwJeICIDeO
 EZ/Xg74oN8+bPeWkxgOfw==
UI-OutboundReport: notjunk:1;M01:P0:dYRvzB3fy8s=;4L/hqyP//xsQXgf9kPsWzkbThry
 k6dADl3yLM371ypb032xXiluUB2phshNURfswKRWv1cUxfILO5OAIGo5EyHJ+AAjphBdeae3H
 Av1oqU9VaGio1A45gjt+69dlcfNS3iAmJYiFx2uuWt8rLPcrlVQ7Mw9UZB04OeUKstSKNBKOk
 kcjh8EZ+ZoIPCgDmKtpna0Vc5dVvqkOGnxVDBGMy8mRFMlHUF6mmv8DJm562ZR6u1HdjdU1h4
 i5MkYX1i2kvYSjIozV6Z6r+Q76f5vXXpu75G5pvE7x0z4BoT159Iofg87qFVHhAwCQokRdJ5V
 5NZBhq8WstIDE7Ag93WWeQLISaJONS0VqDhygzUMb/lxu1Ty2WLEATcKAUaZq1+CVmt8kX7lw
 soBnuy90ujpU1KINVd8ucGtwESYs6hhsHE+oxOipnWPhHOMdj21l8rprh2YeRr1l5HF43B+z4
 /MoUQm3vJXueIGIB45StYuR4c18otinB9c9rNUyCwZJI+2EuVk0tYufMzfXmycr2BJFt0vfoj
 CPLU5zkTVMeZBssKeseHDW9ZZRu//W/x3v6Zs53RszbTnyZeaa82zXgMg0rXLucP/KWG8bXMB
 z268/0+ON6EzgJN6+FhrqsvS9RQ0beeBiBiZNwdRAh5a4zvSu4loqmjvAoy4w/bOBGGJY8KwB
 wnEz5k01/9yrdpvVd7m1SiXkRW/K3pYJDPpoHYgJyIAqKYPVi14iJ4U0qgjGoOnC64VbOkIKb
 9rcWfC8ltlB5oL00N0xnsVpMXuKJlHKiwhB/kCBkPzCya7lcKzXVWDwitSCuEcJxgnLBnVwEC
 mZY4ySV/HyN9hgNXjfe7QGnMqbv1B64NQzsZCPMV+K88EGAqr3dyx8xbAgoLuItmrDf1frqy8
 Hh07fE5TjJG9rIzk1kfqoTIvwubjmQeJtL0Wsj5zihWT5m3wxlJU1+gjvkMKKHDEFp1vZD1iE
 QhaMc8NrVRHh+fQZewmUrP29R/o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/11 18:32, kernel test robot wrote:
> Hi Qu,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on linus/master v6.5-rc5 next-20230809]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-r=
emove-v0-extent-handling/20230811-154905
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> patch link:    https://lore.kernel.org/r/6258b0bf5e41e52ca0e163e34650d18=
6363628c6.1691740017.git.wqu%40suse.com
> patch subject: [PATCH v2] btrfs: remove v0 extent handling
> config: powerpc-randconfig-r034-20230811 (https://download.01.org/0day-c=
i/archive/20230811/202308111815.mJwoiury-lkp@intel.com/config)

OK, ppc, that's why we need a different format for sizeof() return values.

> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git=
 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230811/20230811181=
5.mJwoiury-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308111815.mJwoiury-lk=
p@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> fs/btrfs/print-tree.c:100:17: warning: format specifies type 'unsigned=
 long' but the argument has type 'unsigned int' [-Wformat]
>       100 |                           "unexpected extent item size, has =
%u expect >=3D %lu",
>           |                                                             =
             ~~~
>           |                                                             =
             %u

The more proper format would be %zu.

Would be updated soon.

Thanks for the report as usual,
Qu

>       101 |                           item_size, sizeof(*ei));
>           |                                      ^~~~~~~~~~~
>     fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
>        46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
>           |                                        ~~~    ^~~~
>     fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
>        27 |         _btrfs_printk(fs_info, fmt, ##args)
>           |                                ~~~    ^~~~
>     1 warning generated.
> --
>>> fs/btrfs/extent-tree.c:172:18: warning: format specifies type 'unsigne=
d long' but the argument has type 'unsigned int' [-Wformat]
>       172 |                         "unexpected extent item size, has %u=
 expect >=3D %lu",
>           |                                                             =
           ~~~
>           |                                                             =
           %u
>       173 |                                   item_size, sizeof(*ei));
>           |                                              ^~~~~~~~~~~
>     fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
>        46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
>           |                                        ~~~    ^~~~
>     fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
>        27 |         _btrfs_printk(fs_info, fmt, ##args)
>           |                                ~~~    ^~~~
>     fs/btrfs/extent-tree.c:867:17: warning: format specifies type 'unsig=
ned long' but the argument has type 'unsigned int' [-Wformat]
>       867 |                           "unexpected extent item size, has =
%llu expect >=3D %lu",
>           |                                                             =
               ~~~
>           |                                                             =
               %u
>       868 |                           item_size, sizeof(*ei));
>           |                                      ^~~~~~~~~~~
>     fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
>        46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
>           |                                        ~~~    ^~~~
>     fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
>        27 |         _btrfs_printk(fs_info, fmt, ##args)
>           |                                ~~~    ^~~~
>     fs/btrfs/extent-tree.c:1671:17: warning: format specifies type 'unsi=
gned long' but the argument has type 'unsigned int' [-Wformat]
>      1671 |                           "unexpected extent item size, has =
%u expect >=3D %lu",
>           |                                                             =
             ~~~
>           |                                                             =
             %u
>      1672 |                           item_size, sizeof(*ei));
>           |                                      ^~~~~~~~~~~
>     fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
>        46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
>           |                                        ~~~    ^~~~
>     fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
>        27 |         _btrfs_printk(fs_info, fmt, ##args)
>           |                                ~~~    ^~~~
>     fs/btrfs/extent-tree.c:3102:17: warning: format specifies type 'unsi=
gned long' but the argument has type 'unsigned int' [-Wformat]
>      3102 |                           "unexpected extent item size, has =
%u expect >=3D %lu",
>           |                                                             =
             ~~~
>           |                                                             =
             %u
>      3103 |                           item_size, sizeof(*ei));
>           |                                      ^~~~~~~~~~~
>     fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
>        46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
>           |                                        ~~~    ^~~~
>     fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
>        27 |         _btrfs_printk(fs_info, fmt, ##args)
>           |                                ~~~    ^~~~
>     4 warnings generated.
>
> Kconfig warnings: (for reference only)
>     WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>     Depends on [n]: SMP [=3Dy] && (PPC_PSERIES [=3Dn] || PPC_PMAC [=3Dn]=
 || PPC_POWERNV [=3Dn] || FSL_SOC_BOOKE [=3Dn])
>     Selected by [y]:
>     - PM_SLEEP_SMP [=3Dy] && SMP [=3Dy] && (ARCH_SUSPEND_POSSIBLE [=3Dy]=
 || ARCH_HIBERNATION_POSSIBLE [=3Dy]) && PM_SLEEP [=3Dy]
>
>
> vim +100 fs/btrfs/print-tree.c
>
>      82
>      83	static void print_extent_item(const struct extent_buffer *eb, in=
t slot, int type)
>      84	{
>      85		struct btrfs_extent_item *ei;
>      86		struct btrfs_extent_inline_ref *iref;
>      87		struct btrfs_extent_data_ref *dref;
>      88		struct btrfs_shared_data_ref *sref;
>      89		struct btrfs_disk_key key;
>      90		unsigned long end;
>      91		unsigned long ptr;
>      92		u32 item_size =3D btrfs_item_size(eb, slot);
>      93		u64 flags;
>      94		u64 offset;
>      95		int ref_index =3D 0;
>      96
>      97		if (unlikely(item_size < sizeof(*ei))) {
>      98			btrfs_err(eb->fs_info,
>      99				  "unexpected extent item size, has %u expect >=3D %lu",
>   > 100				  item_size, sizeof(*ei));
>     101			btrfs_handle_fs_error(eb->fs_info, -EUCLEAN, NULL);
>     102		}
>     103
>     104		ei =3D btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
>     105		flags =3D btrfs_extent_flags(eb, ei);
>     106
>     107		pr_info("\t\textent refs %llu gen %llu flags %llu\n",
>     108		       btrfs_extent_refs(eb, ei), btrfs_extent_generation(eb, e=
i),
>     109		       flags);
>     110
>     111		if ((type =3D=3D BTRFS_EXTENT_ITEM_KEY) &&
>     112		    flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
>     113			struct btrfs_tree_block_info *info;
>     114			info =3D (struct btrfs_tree_block_info *)(ei + 1);
>     115			btrfs_tree_block_key(eb, info, &key);
>     116			pr_info("\t\ttree block key (%llu %u %llu) level %d\n",
>     117			       btrfs_disk_key_objectid(&key), key.type,
>     118			       btrfs_disk_key_offset(&key),
>     119			       btrfs_tree_block_level(eb, info));
>     120			iref =3D (struct btrfs_extent_inline_ref *)(info + 1);
>     121		} else {
>     122			iref =3D (struct btrfs_extent_inline_ref *)(ei + 1);
>     123		}
>     124
>     125		ptr =3D (unsigned long)iref;
>     126		end =3D (unsigned long)ei + item_size;
>     127		while (ptr < end) {
>     128			iref =3D (struct btrfs_extent_inline_ref *)ptr;
>     129			type =3D btrfs_extent_inline_ref_type(eb, iref);
>     130			offset =3D btrfs_extent_inline_ref_offset(eb, iref);
>     131			pr_info("\t\tref#%d: ", ref_index++);
>     132			switch (type) {
>     133			case BTRFS_TREE_BLOCK_REF_KEY:
>     134				pr_cont("tree block backref root %llu\n", offset);
>     135				break;
>     136			case BTRFS_SHARED_BLOCK_REF_KEY:
>     137				pr_cont("shared block backref parent %llu\n", offset);
>     138				/*
>     139				 * offset is supposed to be a tree block which
>     140				 * must be aligned to nodesize.
>     141				 */
>     142				if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
>     143					pr_info(
>     144				"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
>     145						offset, eb->fs_info->sectorsize);
>     146				break;
>     147			case BTRFS_EXTENT_DATA_REF_KEY:
>     148				dref =3D (struct btrfs_extent_data_ref *)(&iref->offset);
>     149				print_extent_data_ref(eb, dref);
>     150				break;
>     151			case BTRFS_SHARED_DATA_REF_KEY:
>     152				sref =3D (struct btrfs_shared_data_ref *)(iref + 1);
>     153				pr_cont("shared data backref parent %llu count %u\n",
>     154				       offset, btrfs_shared_data_ref_count(eb, sref));
>     155				/*
>     156				 * Offset is supposed to be a tree block which must be
>     157				 * aligned to sectorsize.
>     158				 */
>     159				if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
>     160					pr_info(
>     161				"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
>     162					     offset, eb->fs_info->sectorsize);
>     163				break;
>     164			default:
>     165				pr_cont("(extent %llu has INVALID ref type %d)\n",
>     166					  eb->start, type);
>     167				return;
>     168			}
>     169			ptr +=3D btrfs_extent_inline_ref_size(type);
>     170		}
>     171		WARN_ON(ptr > end);
>     172	}
>     173
>
