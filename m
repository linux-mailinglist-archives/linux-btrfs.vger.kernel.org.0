Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1F9799CB3
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Sep 2023 06:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbjIJE6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Sep 2023 00:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjIJE6t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Sep 2023 00:58:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AFC1BF
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 21:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694321920; x=1694926720; i=quwenruo.btrfs@gmx.com;
 bh=2x0ziZPrqH2bOURaXLbquvFdgjMHeVp4EcDUh84tTd4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=AK5t5O+zrcAINp5nxturTpLggGXL9f81mUNenLD1TkbNzP8KblRMPqLu3HUGvyGGqJlaw1h
 8X+4gxGLh9Op8uBbyaBisLNzW+5asf8dDoG5ykjshpc4IL4K5JcpAYy0z3YOIqBzA6/BYwWDL
 Twkt91tgKDxFGpV/pgteQmuJ5tv8/baK4Jj/rk/ZDH1ucWhxyQ+Ugi+Dq+am+8CKB/3/aq0CO
 6u8w/XQ8QqLJ64Kt3ebYbhJeTjWySNUKVMmg6dIkXAQyCy7AL5GwJ9wWOVAYOtNUwyrJTHOyC
 34sDxp9OlhK4tP+mygAhP+GuDtTkzRkwWaS8GH+78NN2KfAGStuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.7.112.80] ([154.6.151.166]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvK4Z-1poCMw2UQD-00rGMI; Sun, 10
 Sep 2023 06:58:40 +0200
Message-ID: <43024b78-debe-4764-8dc2-098e398df719@gmx.com>
Date:   Sun, 10 Sep 2023 14:28:36 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: rename errno identifiers to error
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230908191006.31940-1-dsterba@suse.com>
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
In-Reply-To: <20230908191006.31940-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HRPPEMonXtbBpA8mYPoqov5EE7q6zDOVoBkLbeojFaehJjh7O0M
 k24IkfG/lTz2B/ADRCSic6Qn3r9yYFyCRsCidl01twEfGBvrFt6IpvQXvQbh4CTkciwfD0K
 dd6h5b+w+NBwNP+xRgyFFlHFqmPgHLFR3CS7uXowCWPqXW4uR7aJQHbqso2hR9sn5jscTOe
 EitAEir/dkBj/X19K1vuw==
UI-OutboundReport: notjunk:1;M01:P0:64IQRPhecho=;QpYRz34twHOXdL852eKlVLVifT5
 qdShAjwY+91lwLnBaYuZk9mZlCm95whHYY03ONR33LydvfXYI/dITghtrDM+Se8joeFjFnP2L
 h96vDsp8C/cFEbcZOM4dfKU9pME25GyZ5LDhagWvbRW0J/vIgUobt419qTtzboLUN46AxewGX
 QyPvmGgtiMA3qzdarkyRabHPAw7ZZ/ip1JRo8tBchfOW8RDSWMDm/NxXl7GcY8uQ/rl8tW+8A
 Ae9LW2swfgKIJd2VcCqx3ByCakY5w0qsQM8putwFjcexVJcvUIzhbxIzREc6D1GdAH1GARkB0
 oS19t6nTjm3l5wAsc+RpQTzWtPwybTH72jCGR4u/3HtWv7haS3LTq2Bf3hTXCkDkqPz7eAbYv
 pwbuMPruWlatvybpDsr+HndHjkHEome4OpSlIj74E/3+hcgXsr/PESHKYjQXOrPQA0B+XwLJi
 PwND3ye6xtZR4BC5Xg6XYvWU0S71INuMLUAU6PQ2/8o31LyH7Jg9ChPIKViCUQDIhcHFYmhf/
 hvwi8mCF7Ckvme76D/RDvxxCVNcmi8loY9dEo0EYgEfCuLossVcklk/QVeQC9RSbC5RYxD+v2
 UHjJzURk9g7txSwnCltPYwD5iiVhEDcmzozs0UtFLd0M9qyEVpzOsGV9/YD6pgKLZlaC5Fct1
 WoSTioqh+ZhIvmtR4H5yxnZyv9oqJGXuY5CF353ziOFPzvq2nYmUFj3mgybyO1DeFXK0DT5rr
 vy2KLD5JCYyDAr5zl02lImFRnoF5nzcEbdKRXSjklTd3HGjGzuqZRggFWNWmuYZ3s4Lxu1avZ
 BS4IXUYfzCEI0mQLirVgorYaBDPj1tM4kU8SUO+3xpjN+L2n441UkA1Df2QSDtuNfkJEaC1VN
 EVbi3BvBlarbMs2b1Gcd3wHwIpui3ZgnXxCpmjUnp5xtdHMyLz3Pu4OGb69kG0WraN3jYseyd
 8PopOqHemPCdbF55q+D654LuS4s=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/9 04:40, David Sterba wrote:
> We sync the kernel files to userspace and the 'errno' symbol is defined
> by standard library, which does not matter in kernel but the parameters
> or local variables could clash. Rename them all.

Well, initially I thought this problem should be exposed by -Wshadow in
btrfs-progs, but I'm wrong.

When going W=3D2 for btrfs-progs, we indeed got some error on some shadows
but not any @errno one in the current devel.

Is there some warning option we can use in progs to expose such warnings?

>
> Signed-off-by: David Sterba <dsterba@suse.com>

The patch itself looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/backref.h     |  4 ++--
>   fs/btrfs/compression.c |  6 +++---
>   fs/btrfs/ctree.c       |  4 ++--
>   fs/btrfs/messages.c    | 24 ++++++++++++------------
>   fs/btrfs/messages.h    | 14 +++++++-------
>   fs/btrfs/transaction.c | 10 +++++-----
>   fs/btrfs/transaction.h | 14 +++++++-------
>   7 files changed, 38 insertions(+), 38 deletions(-)
>
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 79742935399f..3b077d10bbc0 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -533,9 +533,9 @@ void btrfs_backref_cleanup_node(struct btrfs_backref=
_cache *cache,
>   void btrfs_backref_release_cache(struct btrfs_backref_cache *cache);
>
>   static inline void btrfs_backref_panic(struct btrfs_fs_info *fs_info,
> -				       u64 bytenr, int errno)
> +				       u64 bytenr, int error)
>   {
> -	btrfs_panic(fs_info, errno,
> +	btrfs_panic(fs_info, error,
>   		    "Inconsistency in backref cache found at offset %llu",
>   		    bytenr);
>   }
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 8818ed5c390f..19b22b4653c8 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -193,12 +193,12 @@ static noinline void end_compressed_writeback(cons=
t struct compressed_bio *cb)
>   	unsigned long index =3D cb->start >> PAGE_SHIFT;
>   	unsigned long end_index =3D (cb->start + cb->len - 1) >> PAGE_SHIFT;
>   	struct folio_batch fbatch;
> -	const int errno =3D blk_status_to_errno(cb->bbio.bio.bi_status);
> +	const int error =3D blk_status_to_errno(cb->bbio.bio.bi_status);
>   	int i;
>   	int ret;
>
> -	if (errno)
> -		mapping_set_error(inode->i_mapping, errno);
> +	if (error)
> +		mapping_set_error(inode->i_mapping, error);
>
>   	folio_batch_init(&fbatch);
>   	while (index <=3D end_index) {
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 6d18f6d5a8b3..c362472a112f 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -230,9 +230,9 @@ noinline void btrfs_release_path(struct btrfs_path *=
p)
>    * cause could be a bug, eg. due to ENOSPC, and not for common errors =
that are
>    * caused by external factors.
>    */
> -bool __cold abort_should_print_stack(int errno)
> +bool __cold abort_should_print_stack(int error)
>   {
> -	switch (errno) {
> +	switch (error) {
>   	case -EIO:
>   	case -EROFS:
>   	case -ENOMEM:
> diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
> index 5be060cb6ef5..b8f9c9e56c8c 100644
> --- a/fs/btrfs/messages.c
> +++ b/fs/btrfs/messages.c
> @@ -72,11 +72,11 @@ static void btrfs_state_to_string(const struct btrfs=
_fs_info *info, char *buf)
>    *        over the error.  Each subsequent error that doesn't have any=
 context
>    *        of the original error should use EROFS when handling BTRFS_F=
S_STATE_ERROR.
>    */
> -const char * __attribute_const__ btrfs_decode_error(int errno)
> +const char * __attribute_const__ btrfs_decode_error(int error)
>   {
>   	char *errstr =3D "unknown";
>
> -	switch (errno) {
> +	switch (error) {
>   	case -ENOENT:		/* -2 */
>   		errstr =3D "No such entry";
>   		break;
> @@ -115,7 +115,7 @@ const char * __attribute_const__ btrfs_decode_error(=
int errno)
>    */
>   __cold
>   void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char=
 *function,
> -		       unsigned int line, int errno, const char *fmt, ...)
> +		       unsigned int line, int error, const char *fmt, ...)
>   {
>   	struct super_block *sb =3D fs_info->sb;
>   #ifdef CONFIG_PRINTK
> @@ -132,11 +132,11 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info =
*fs_info, const char *function
>   	 * Special case: if the error is EROFS, and we're already under
>   	 * SB_RDONLY, then it is safe here.
>   	 */
> -	if (errno =3D=3D -EROFS && sb_rdonly(sb))
> +	if (error =3D=3D -EROFS && sb_rdonly(sb))
>   		return;
>
>   #ifdef CONFIG_PRINTK
> -	errstr =3D btrfs_decode_error(errno);
> +	errstr =3D btrfs_decode_error(error);
>   	btrfs_state_to_string(fs_info, statestr);
>   	if (fmt) {
>   		struct va_format vaf;
> @@ -147,11 +147,11 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info =
*fs_info, const char *function
>   		vaf.va =3D &args;
>
>   		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=3D%d %s (%pV)\n"=
,
> -			sb->s_id, statestr, function, line, errno, errstr, &vaf);
> +			sb->s_id, statestr, function, line, error, errstr, &vaf);
>   		va_end(args);
>   	} else {
>   		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=3D%d %s\n",
> -			sb->s_id, statestr, function, line, errno, errstr);
> +			sb->s_id, statestr, function, line, error, errstr);
>   	}
>   #endif
>
> @@ -159,7 +159,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *f=
s_info, const char *function
>   	 * Today we only save the error info to memory.  Long term we'll also
>   	 * send it down to the disk.
>   	 */
> -	WRITE_ONCE(fs_info->fs_error, errno);
> +	WRITE_ONCE(fs_info->fs_error, error);
>
>   	/* Don't go through full error handling during mount. */
>   	if (!(sb->s_flags & SB_BORN))
> @@ -288,7 +288,7 @@ void __cold btrfs_err_32bit_limit(struct btrfs_fs_in=
fo *fs_info)
>    */
>   __cold
>   void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function=
,
> -		   unsigned int line, int errno, const char *fmt, ...)
> +		   unsigned int line, int error, const char *fmt, ...)
>   {
>   	char *s_id =3D "<unknown>";
>   	const char *errstr;
> @@ -301,13 +301,13 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, =
const char *function,
>   	va_start(args, fmt);
>   	vaf.va =3D &args;
>
> -	errstr =3D btrfs_decode_error(errno);
> +	errstr =3D btrfs_decode_error(error);
>   	if (fs_info && (btrfs_test_opt(fs_info, PANIC_ON_FATAL_ERROR)))
>   		panic(KERN_CRIT "BTRFS panic (device %s) in %s:%d: %pV (errno=3D%d %=
s)\n",
> -			s_id, function, line, &vaf, errno, errstr);
> +			s_id, function, line, &vaf, error, errstr);
>
>   	btrfs_crit(fs_info, "panic in %s:%d: %pV (errno=3D%d %s)",
> -		   function, line, &vaf, errno, errstr);
> +		   function, line, &vaf, error, errstr);
>   	va_end(args);
>   	/* Caller calls BUG() */
>   }
> diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> index 1ae6f8e23e07..4d04c1fa5899 100644
> --- a/fs/btrfs/messages.h
> +++ b/fs/btrfs/messages.h
> @@ -184,25 +184,25 @@ do {								\
>   __printf(5, 6)
>   __cold
>   void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char=
 *function,
> -		     unsigned int line, int errno, const char *fmt, ...);
> +		     unsigned int line, int error, const char *fmt, ...);
>
> -const char * __attribute_const__ btrfs_decode_error(int errno);
> +const char * __attribute_const__ btrfs_decode_error(int error);
>
> -#define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
> +#define btrfs_handle_fs_error(fs_info, error, fmt, args...)		\
>   	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
> -				(errno), fmt, ##args)
> +				(error), fmt, ##args)
>
>   __printf(5, 6)
>   __cold
>   void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function=
,
> -		   unsigned int line, int errno, const char *fmt, ...);
> +		   unsigned int line, int error, const char *fmt, ...);
>   /*
>    * If BTRFS_MOUNT_PANIC_ON_FATAL_ERROR is in mount_opt, __btrfs_panic
>    * will panic().  Otherwise we BUG() here.
>    */
> -#define btrfs_panic(fs_info, errno, fmt, args...)			\
> +#define btrfs_panic(fs_info, error, fmt, args...)			\
>   do {									\
> -	__btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args);	\
> +	__btrfs_panic(fs_info, __func__, __LINE__, error, fmt, ##args);	\
>   	BUG();								\
>   } while (0)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 035e7f5747cd..d409e1741a2e 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2654,18 +2654,18 @@ int btrfs_clean_one_deleted_snapshot(struct btrf=
s_fs_info *fs_info)
>    */
>   void __cold __btrfs_abort_transaction(struct btrfs_trans_handle *trans=
,
>   				      const char *function,
> -				      unsigned int line, int errno, bool first_hit)
> +				      unsigned int line, int error, bool first_hit)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>
> -	WRITE_ONCE(trans->aborted, errno);
> -	WRITE_ONCE(trans->transaction->aborted, errno);
> -	if (first_hit && errno =3D=3D -ENOSPC)
> +	WRITE_ONCE(trans->aborted, error);
> +	WRITE_ONCE(trans->transaction->aborted, error);
> +	if (first_hit && error =3D=3D -ENOSPC)
>   		btrfs_dump_space_info_for_trans_abort(fs_info);
>   	/* Wake up anybody who may be waiting on this transaction */
>   	wake_up(&fs_info->transaction_wait);
>   	wake_up(&fs_info->transaction_blocked_wait);
> -	__btrfs_handle_fs_error(fs_info, function, line, errno, NULL);
> +	__btrfs_handle_fs_error(fs_info, function, line, error, NULL);
>   }
>
>   int __init btrfs_transaction_init(void)
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 6b309f8a99a8..eca2f81d9e0b 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -200,32 +200,32 @@ static inline void btrfs_clear_skip_qgroup(struct =
btrfs_trans_handle *trans)
>   	delayed_refs->qgroup_to_skip =3D 0;
>   }
>
> -bool __cold abort_should_print_stack(int errno);
> +bool __cold abort_should_print_stack(int error);
>
>   /*
>    * Call btrfs_abort_transaction as early as possible when an error con=
dition is
>    * detected, that way the exact stack trace is reported for some error=
s.
>    */
> -#define btrfs_abort_transaction(trans, errno)		\
> +#define btrfs_abort_transaction(trans, error)		\
>   do {								\
>   	bool first =3D false;					\
>   	/* Report first abort since mount */			\
>   	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
>   			&((trans)->fs_info->fs_state))) {	\
>   		first =3D true;					\
> -		if (WARN(abort_should_print_stack(errno),	\
> +		if (WARN(abort_should_print_stack(error),	\
>   			KERN_ERR				\
>   			"BTRFS: Transaction aborted (error %d)\n",	\
> -			(errno))) {					\
> +			(error))) {					\
>   			/* Stack trace printed. */			\
>   		} else {						\
>   			btrfs_debug((trans)->fs_info,			\
>   				    "Transaction aborted (error %d)", \
> -				  (errno));			\
> +				  (error));			\
>   		}						\
>   	}							\
>   	__btrfs_abort_transaction((trans), __func__,		\
> -				  __LINE__, (errno), first);	\
> +				  __LINE__, (error), first);	\
>   } while (0)
>
>   int btrfs_end_transaction(struct btrfs_trans_handle *trans);
> @@ -264,7 +264,7 @@ void btrfs_add_dropped_root(struct btrfs_trans_handl=
e *trans,
>   void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *tra=
ns);
>   void __cold __btrfs_abort_transaction(struct btrfs_trans_handle *trans=
,
>   				      const char *function,
> -				      unsigned int line, int errno, bool first_hit);
> +				      unsigned int line, int error, bool first_hit);
>
>   int __init btrfs_transaction_init(void);
>   void __cold btrfs_transaction_exit(void);
