Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0635BD7C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 01:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiISXAM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 19:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISXAK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 19:00:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DCA1D310
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663628405;
        bh=vAtTKouH4yk1+DsArSAfonvfDE874qwf2dfpAhKz0EM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WmvJ79D4t6TfV6IBG5pdPC5i5yebTFJVNl9zIRKSKt3wej1NgDm5IJlBEjZje9et2
         kGBxz+lPuA5IilbrbC0uXeeDetIXV4jn6M6qVPLO0zuhN0ppt6xEGxq9FuZ/cBl7zm
         1xbZ+DlY+PximnUfNeV7sYCg1p1i8B2M+KWpVcSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1pBfMy2XTU-00fyzx; Tue, 20
 Sep 2022 01:00:05 +0200
Message-ID: <41969ffc-230b-5cd6-4d4d-d001f4bad7d9@gmx.com>
Date:   Tue, 20 Sep 2022 07:00:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC] btrfs: make btrfs module init/exit match their
 sequence
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <5d2d69afe8edaf99b92c07acc17a603e692a5990.1663569042.git.wqu@suse.com>
 <20220919201348.GT32411@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220919201348.GT32411@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6VfndsO+LvUWEtd47SgqHQEBBpurRo/VXMXrWLccEh6sqZvRxgu
 5ZXpg2hsIWkSC69YNBnDhOMFYI9aDQSVNieAdnCrsgZM3Kkwfr3ZO5e/fRDDSrGswdVIXnC
 zu6T9DATow2JSVfwfx++aqXy8vS/f6ePiywx/D2Gss+/C7qPBIxlz2MHRtxABp6P6p82d+8
 8xmSsNO+wEhxXWGxlATtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TwHYAQe5ftM=:awCtb46pV3PjXOQc1Z6sby
 fR9cbvM59QwITV+lPuGcTK28Zks946Ku3TOwZFoBJrCVX62V42l8Y4ECiBuUzL+kzhdL6PAkF
 5Ep/Y+7qEyypP/S9Sl1EIDXO5Z7X885Z5OqcL3H8zEvXcvvYPj9y/aBNhbSha1ziPBvX+3daz
 japXZu5XG1msI/bof7E8wFWJtB0t2KgqiDs0nOj8ODA/SIZR49ylGGMOnjfiJolJz+OwhqRMv
 BVEjxo9dGr4T6QgIYhHkZL//X4TPJOpotl5qLkGbeqPeP0fQq6PNSv9u41R5lAVFIknn1KU1a
 w7hPxTcT9wPuXOHUjf86IW4LqK1H1lLW5V+Fib6I8HnD5UKxYNhKtxOurzRUybE2mIyyIPh6f
 zmO44FJtqQ6GW6te3Xn4e2Vm1lz4eOTCmhx0zpqltFxYfVYuQeNyI5Os4lDZ2CZfFqgpCAxS/
 FDQ9UoRdcpAPa7ip6VOWg8+eeKo9mZUQK/XKGY9McqZLxhTATe7Lz5Wrd+SlTIM76km36wZmC
 bwYgbQRPxQeon1z7CsdogysjkH8iIqqIhevtDpi4aaK+dxLirDPRBRWzp+C5TuRJel2XKGZdZ
 kQEixoqrQSbgDIUR8Gg9oO64v1W0R/vVC7WSshuGm250FxV78fIyYCSsf0h+WhCP39e/LxqkD
 eGtYx7lrKpe0cIf8BXuinfcPxxWMiNoyHrJ2+g+XyWbeC9b2wgeqvs9Rlnw/ALHh4WMNsfSdp
 1Fut70Mq3w/EvmmsDLAQ1TRZ5G/AgiE77iMUAdCsMBIXmswOJbaVea6M2oWaGDeWC3pjItCoG
 c7sPLxeFsePAkjeoQv7FG0KQwgDJe+jA0fkTPx05KMb1mEIVQc7Z7FW/rsXRMC1Df8VUy/FdT
 LjWKQTRN0Hx7WhQ6pEKabq5ZdeG9h6xT3du0hTeSV3fzgB8qFxV2FMec17Es0rCRLywpxiYlQ
 omFI8UsNgNfdaak3kAtgrqnqLGyHTUBKAqJmbFqeigNuBYKfdx+yWWFcZ+C4jAzjKEHGx+bBO
 5kQUaR/Bcd8Pw/7l8etu4stNlLpK1r5WtPGDvlCrRKvyC/VMCvyxqovjpo9B1JnJhSqdoW+Ln
 GQCJwute9o6M2Iky+EY8iYwlGt0c1cRWcHwSAZw4uA4vf+1Epfm8+TYkMS4z0gTLpTYB2OYoX
 geUsDDhQ7uHZqnaiYWsT6/f5/A
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/20 04:13, David Sterba wrote:
> On Mon, Sep 19, 2022 at 02:36:44PM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>> In theory init_btrfs_fs() and exit_btrfs_fs() should match their
>> sequence, thus normally they should look like this:
>>
>>      init_btrfs_fs()   |   exit_btrfs_fs()
>> ----------------------+------------------------
>>      init_A();         |
>>      init_B();         |
>>      init_C();         |
>>                        |   exit_C();
>>                        |   exit_B();
>>                        |   exit_A();
>>
>> So is for the error path of init_btrfs_fs().
>>
>> But it's not the case, some exit functions don't match their init
>> functions sequence in init_btrfs_fs().
>>
>> Furthermore in init_btrfs_fs(), we need to have a new error tag for eac=
h
>> new init function we added.
>> This is not really expandable, especially recently we may add several
>> new functions to init_btrfs_fs().
>>
>> [ENHANCEMENT]
>> The patch will introduce the following things to enhance the situation:
>>
>> - struct init_sequence
>>    Just a wrapper of init and exit function pointers.
>>
>>    The init function must use int type as return value, thus some init
>>    functions need to be updated to return 0.
>>
>>    The exit function can be NULL, as there are some init sequence just
>>    outputting a message.
>>
>> - struct mod_init_seq[] array
>>    This is a const array, recording all the initialization we need to d=
o
>>    in init_btrfs_fs(), and the order follows the old init_btrfs_fs().
>>
>>    Only one modification in the order, now we call btrfs_print_mod_info=
()
>>    after sanity checks.
>>    As it makes no sense to print the mod into, and fail the sanity test=
s.
>>
>> - bool mod_init_result[] array
>>    This is a bool array, recording if we have initialized one entry in
>>    mod_init_seq[].
>>
>>    The reason to split mod_init_seq[] and mod_init_result[] is to avoid
>>    section mismatch in reference.
>>
>>    All init function are in .init.text, but if mod_init_seq[] records
>>    the @initialized member it can no longer be const, thus will be put
>>    into .data section, and cause modpost warning.
>>
>> For init_btrfs_fs() we just call all init functions in their order in
>> mod_init_seq[] array, and after each call, setting corresponding
>> mod_init_result[] to true.
>>
>> For exit_btrfs_fs() and error handling path of init_btrfs_fs(), we just
>> iterate mod_init_seq[] in reverse order, and skip all uninitialized
>> entry.
>>
>> With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier to
>> expand and will always follow the strict order.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> Although the patch is tested with multiple load/unload and fstests runs=
,
>> this should cause extra memory usage, 272 bytes for the single use
>> mod_init_seq[] array and at least 17 bytes for mod_init_result[].
>
> I think the bytes will move from code to the data section, so I would
> not consider it a big problem.
>
>> And it also introduced some duplicated code, as we can not call
>> exit_btrfs_fs() inside init_btrfs_fs(), or we will trigger modpost
>> warning for the section type mismatch in the reference.
>>
>> Another solution is, to make all exit functions to handle the cleanup
>> automatically.
>>
>> This is feasible for most cachep related init/exit, just some extra
>> "if (cachep) {" checks.
>> But some other ones may need extra work.
>> Furthermore such smart exit function can not address the sequence
>> problem, only making the error handling patch a little cleaner.
>>
>> Thus currently I follow the array solution for this.
>>
>> If this method is fine, maybe I can follow the same way for open_ctree(=
).
>
> I like it, the order of the functions is clear and makes it easy to
> extend in one place. As now implemented I don't see anything oubvious
> that would need an improvement so the suggested optimizations we can
> consider separately.
>
>> ---
>>   fs/btrfs/compression.c |   3 +-
>>   fs/btrfs/compression.h |   2 +-
>>   fs/btrfs/props.c       |   3 +-
>>   fs/btrfs/props.h       |   2 +-
>>   fs/btrfs/super.c       | 211 +++++++++++++++++++++-------------------=
-
>>   5 files changed, 112 insertions(+), 109 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 54caa00a2245..8d3e3218fe37 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -1232,12 +1232,13 @@ int btrfs_decompress(int type, unsigned char *d=
ata_in, struct page *dest_page,
>>   	return ret;
>>   }
>>
>> -void __init btrfs_init_compress(void)
>> +int __init btrfs_init_compress(void)
>>   {
>>   	btrfs_init_workspace_manager(BTRFS_COMPRESS_NONE);
>>   	btrfs_init_workspace_manager(BTRFS_COMPRESS_ZLIB);
>>   	btrfs_init_workspace_manager(BTRFS_COMPRESS_LZO);
>>   	zstd_init_workspace_manager();
>> +	return 0;
>>   }
>>
>>   void __cold btrfs_exit_compress(void)
>> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
>> index 1aa02903de69..9da2343eeff5 100644
>> --- a/fs/btrfs/compression.h
>> +++ b/fs/btrfs/compression.h
>> @@ -77,7 +77,7 @@ static inline unsigned int btrfs_compress_level(unsig=
ned int type_level)
>>   	return ((type_level & 0xF0) >> 4);
>>   }
>>
>> -void __init btrfs_init_compress(void);
>> +int __init btrfs_init_compress(void);
>>   void __cold btrfs_exit_compress(void);
>>
>>   int btrfs_compress_pages(unsigned int type_level, struct address_spac=
e *mapping,
>> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
>> index 055a631276ce..abee92eb1ed6 100644
>> --- a/fs/btrfs/props.c
>> +++ b/fs/btrfs/props.c
>> @@ -453,7 +453,7 @@ int btrfs_inode_inherit_props(struct btrfs_trans_ha=
ndle *trans,
>>   	return 0;
>>   }
>>
>> -void __init btrfs_props_init(void)
>> +int __init btrfs_props_init(void)
>>   {
>>   	int i;
>>
>> @@ -463,5 +463,6 @@ void __init btrfs_props_init(void)
>>
>>   		hash_add(prop_handlers_ht, &p->node, h);
>>   	}
>> +	return 0;
>>   }
>>
>> diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
>> index ca9dd3df129b..6e283196e38a 100644
>> --- a/fs/btrfs/props.h
>> +++ b/fs/btrfs/props.h
>> @@ -8,7 +8,7 @@
>>
>>   #include "ctree.h"
>>
>> -void __init btrfs_props_init(void);
>> +int __init btrfs_props_init(void);
>>
>>   int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *in=
ode,
>>   		   const char *name, const char *value, size_t value_len,
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index be7df8d1d5b8..fb30ca46c65c 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2691,7 +2691,7 @@ static __cold void btrfs_interface_exit(void)
>>   	misc_deregister(&btrfs_misc);
>>   }
>>
>> -static void __init btrfs_print_mod_info(void)
>> +static int __init btrfs_print_mod_info(void)
>>   {
>>   	static const char options[] =3D ""
>>   #ifdef CONFIG_BTRFS_DEBUG
>> @@ -2718,122 +2718,123 @@ static void __init btrfs_print_mod_info(void)
>>   #endif
>>   			;
>>   	pr_info("Btrfs loaded, crc32c=3D%s%s\n", crc32c_impl(), options);
>> +	return 0;
>>   }
>>
>> -static int __init init_btrfs_fs(void)
>> +static int register_btrfs(void)
>>   {
>> -	int err;
>> -
>> -	btrfs_props_init();
>> -
>> -	err =3D btrfs_init_sysfs();
>> -	if (err)
>> -		return err;
>> -
>> -	btrfs_init_compress();
>> -
>> -	err =3D btrfs_init_cachep();
>> -	if (err)
>> -		goto free_compress;
>> -
>> -	err =3D extent_state_init_cachep();
>> -	if (err)
>> -		goto free_cachep;
>> -
>> -	err =3D extent_buffer_init_cachep();
>> -	if (err)
>> -		goto free_extent_cachep;
>> -
>> -	err =3D btrfs_bioset_init();
>> -	if (err)
>> -		goto free_eb_cachep;
>> -
>> -	err =3D extent_map_init();
>> -	if (err)
>> -		goto free_bioset;
>> -
>> -	err =3D ordered_data_init();
>> -	if (err)
>> -		goto free_extent_map;
>> -
>> -	err =3D btrfs_delayed_inode_init();
>> -	if (err)
>> -		goto free_ordered_data;
>> -
>> -	err =3D btrfs_auto_defrag_init();
>> -	if (err)
>> -		goto free_delayed_inode;
>> -
>> -	err =3D btrfs_delayed_ref_init();
>> -	if (err)
>> -		goto free_auto_defrag;
>> +	return register_filesystem(&btrfs_fs_type);
>> +}
>> +static void unregister_btrfs(void)
>> +{
>> +	unregister_filesystem(&btrfs_fs_type);
>> +}
>>
>> -	err =3D btrfs_prelim_ref_init();
>> -	if (err)
>> -		goto free_delayed_ref;
>> +/* Helper structure for long init/exit functions. */
>> +struct init_sequence {
>> +	int (*init_func)(void);
>> +	void (*exit_func)(void);
>> +};
>>
>> -	err =3D btrfs_interface_init();
>> -	if (err)
>> -		goto free_prelim_ref;
>> +const struct init_sequence mod_init_seq[] =3D {
>
> Can this be static? Also it could be marked as the __initdata section or
> it's called something like that, like the functions. It can freed some
> resources when the module is built-in.

Yep, for const structure array it can definitely be static without
modpost wanring.

>
>> +	{
>> +		.init_func =3D btrfs_props_init,
>> +		.exit_func =3D NULL,
>
> We can put the defintion in some macro, that would define both callbacks
> if they follow same naming eg. with _init _exit suffix bit it slightly
> obscures the function use. The full list as you've done it is fine for
> first implementation and it could stay as is.

That is possible especially most of the init/exit functions are already
doing the init/exit naming, although we need some renaming to put
init/exit as suffix.

That can be a separate patch for further improvement.

Thanks,
Qu
