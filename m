Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3A0DBA84
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 02:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438783AbfJRASA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 20:18:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:40315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbfJRAR7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 20:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571357869;
        bh=9x0uoFGwrDHnCaXO1S9jHjpqMo92s1qfDfoyQPzR3CY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Lh6LkYBUecx8q72BcZnb9q0xxeBSbap/Fytx1QL9UgN4Fx80YrVrV48k0tgaT1ACe
         Dnmx6L4xA2WJSpkuIzl8hnfYbee377t22DXFLl2+mGq4NiKs8GF5cCambyne7Lxr+x
         Wr0NIKfeeBWv8uHaEwVH9ETrSggamTMJSlBDLR08=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MO9zH-1iesNh10tF-00OWeW; Fri, 18
 Oct 2019 02:17:49 +0200
Subject: Re: [PATCH 5/5] btrfs: document extent buffer locking
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <ed989ccddbc8822e61df533d861d907ce0a43040.1571340084.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <01b47547-44fc-966f-fae2-3b7138f40adc@gmx.com>
Date:   Fri, 18 Oct 2019 08:17:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ed989ccddbc8822e61df533d861d907ce0a43040.1571340084.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kF3ImTLbHfIyXBNuzmuLzRnJcXSRWVi7A"
X-Provags-ID: V03:K1:6S+O+lW7u4Del7l0AGjIIzoz+M5zrY2goErov0uSE1xqQT1HbXW
 JlTBFGh2G329kEsbUPo6oj1aUAJ9OXPiA6YD+icUiEwc5Bb/FOP5CB6D5+8GYrXqfJDsCrh
 eKGnw2rgZ7w6Z1hhPCy0Qpu6EA3Ht/D+jl7tsmQWt02cS/C8vpSB9zuwngGxJdAh2SFNTtz
 0mCWN8zdXowzCvuI7Szjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vax8yBn3W+o=:IGbII6UzHOFbabuWf3oD2W
 g+xl7ylj7xLBSNM0crXTh0RsZJME87rjwbE/Khr7pnnShgM5ooiPOwElFCer94VimDFwQQ4v2
 26VkbNc4qb3LVDss/ZPbGEbTax9aNs15niiHFVV+fSGaVKLHSjrIrFrn3RNnkAWDPoMA+z3Js
 ydplZ0rvdr7RhvJUog30/swcOvkFdrB6xOrwpkWMbYnFRGGk/2tehgwXeQDDzFdQvRmTvX1f2
 2G4/FiiBOTjhKH4hLh3/CvZYtO/9Ch4M5cILsr3f02E3qx1o+mbAUYTV0ObTfgdR6jRs0e3wD
 cG3iowqVBBh83ggo+kr6MFJZu6k64TMXxfXn54WBq9ueFclQegn6ij5UfAcxCmAgt9GDkzgof
 /TLUpB6wmmiI1lne2lF8VmyL76SY2As21elFl62e74FsOSRH0AbkPLEzEMyQw2ZETAsoU6eDv
 hzkJgi/fjNN9kaIJkyQV6Doj+9jUr/ebSvEf1MgePHAtVCKleoIuHaO9PL1iOqp62nn7XoQ6/
 xM4rWLbKxJHGSetGaDtJ7bWjKtSjFpNH2joMwo4DrGjimgl8pN4gGZeWCWwTWobUYodeZmBt5
 uNEo4QU2NFOeOkOzKUZ2knph82s7w53lTenqqILun6tTw7wfGcG9lQ3/2Q6FhaacPiPV7i+9i
 DZI14EZwwo1L/MeJT5uDmb5yeekinEF63pvoR/Tq0Resj0ypzBTMS5lB71XoOp+xgyCqC8KGq
 yrjJnYdBqHWmQmzcvwMVduM5NifxNgBiVIpU/hq7OLnZPehhU3H5VHy+BTOyUpmF/ydXRN3Kv
 gj8oiE9SJs3JXrds9cyG5Xp2nVL3sEgzONuZTNOBXmWv7cbv8cy1/PZYPAV5aRGxnKWAG+cPu
 ihWTAH/x0mKm3Aas7RKLIeJenL1meNPInOB+opiXJH569Od9gDqI1JV2WetaqsoNaHai4hrUB
 eq+VSsi3VBXzz0h+fJ6VR1Cxp1j/xypoGwrs6i2y4uv4k2RJb58MaKjr0nU12lGeCWwzj/wTA
 5DZiNaCf7ScVIN4U3A3FVB5upBbiKzu1nUPGludOmoQiMuBYXtySd6rNS0ZcCEV/WgiYwb4M/
 iT7Yyhqm6PKkhDOZnLHm0AKEZnZb3Ktf73QLNgai+lygsuJbg4YtihvhWjzaLLc4PpbklgyN2
 l+UbKG6gkxj69p8ngP7UcieL7ZTSIKSdGPPWaEOMnWOmUDB9jO2TqGK5b69JUldBCK6xXDXtP
 8PXFexnuLjWNKv1FmgDm64S59Vn8vRSSzDR6rmoI0hikhtSFjPEsATPIQYGk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kF3ImTLbHfIyXBNuzmuLzRnJcXSRWVi7A
Content-Type: multipart/mixed; boundary="AClJMHobbFTMEwAljTo5QKB6DABcMq7QR"

--AClJMHobbFTMEwAljTo5QKB6DABcMq7QR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/18 =E4=B8=8A=E5=8D=883:39, David Sterba wrote:
> Signed-off-by: David Sterba <dsterba@suse.com>

Great document.

Some questions inlined below.
> ---
>  fs/btrfs/locking.c | 110 +++++++++++++++++++++++++++++++++++++++------=

>  1 file changed, 96 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index e0e0430577aa..2a0e828b4470 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -13,6 +13,48 @@
>  #include "extent_io.h"
>  #include "locking.h"
> =20
> +/*
> + * Extent buffer locking
> + * ~~~~~~~~~~~~~~~~~~~~~
> + *
> + * The locks use a custom scheme that allows to do more operations tha=
n are
> + * available fromt current locking primitives. The building blocks are=
 still
> + * rwlock and wait queues.
> + *
> + * Required semantics:
> + *
> + * - reader/writer exclusion
> + * - writer/writer exclusion
> + * - reader/reader sharing
> + * - spinning lock semantics
> + * - blocking lock semantics
> + * - try-lock semantics for readers and writers
> + * - one level nesting, allowing read lock to be taken by the same thr=
ead that
> + *   already has write lock

Any example about this scenario? IIRC there is only one user of nested lo=
ck.
Although we know it exists for a long time, I guess it would be better
trying to remove such call sites?

> + *
> + * The extent buffer locks (also called tree locks) manage access to e=
b data.

One of my concern related to "access to eb data" is, to access some
member, we don't really need any lock at all.

Some members should never change during the lifespan of an eb. E.g.
bytenr, transid.

Some code is already taking advantage of this, like tree-checker
checking the transid without holding a lock.
Not sure if we should take use of this.

> + * We want concurrency of many readers and safe updates. The underlyin=
g locking
> + * is done by read-write spinlock and the blocking part is implemented=
 using
> + * counters and wait queues.
> + *
> + * spinning semantics - the low-level rwlock is held so all other thre=
ads that
> + *                      want to take it are spinning on it.
> + *
> + * blocking semantics - the low-level rwlock is not held but the count=
er
> + *                      denotes how many times the blocking lock was h=
eld;
> + *                      sleeping is possible

What about an example/state machine of all read/write and
spinning/blocking combination?

Thanks,
Qu

> + *
> + * Write lock always allows only one thread to access the data.
> + *
> + *
> + * Debugging
> + * ~~~~~~~~~
> + *
> + * There are additional state counters that are asserted in various co=
ntexts,
> + * removed from non-debug build to reduce extent_buffer size and for
> + * performance reasons.
> + */
> +
>  #ifdef CONFIG_BTRFS_DEBUG
>  static inline void btrfs_assert_spinning_writers_get(struct extent_buf=
fer *eb)
>  {
> @@ -80,6 +122,15 @@ static void btrfs_assert_tree_write_locks_get(struc=
t extent_buffer *eb) { }
>  static void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb=
) { }
>  #endif
> =20
> +/*
> + * Mark already held read lock as blocking. Can be nested in write loc=
k by the
> + * same thread.
> + *
> + * Use when there are potentially long operations ahead so other threa=
d waiting
> + * on the lock will not actively spin but sleep instead.
> + *
> + * The rwlock is released and blocking reader counter is increased.
> + */
>  void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
>  {
>  	trace_btrfs_set_lock_blocking_read(eb);
> @@ -96,6 +147,14 @@ void btrfs_set_lock_blocking_read(struct extent_buf=
fer *eb)
>  	read_unlock(&eb->lock);
>  }
> =20
> +/*
> + * Mark already held write lock as blocking.
> + *
> + * Use when there are potentially long operations ahead so other threa=
ds
> + * waiting on the lock will not actively spin but sleep instead.
> + *
> + * The rwlock is released and blocking writers is set.
> + */
>  void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
>  {
>  	trace_btrfs_set_lock_blocking_write(eb);
> @@ -127,8 +186,13 @@ void btrfs_set_lock_blocking_write(struct extent_b=
uffer *eb)
>  }
> =20
>  /*
> - * take a spinning read lock.  This will wait for any blocking
> - * writers
> + * Lock the extent buffer for read. Wait for any writers (spinning or =
blocking).
> + * Can be nested in write lock by the same thread.
> + *
> + * Use when the locked section does only lightweight actions and busy =
waiting
> + * would be cheaper than making other threads do the wait/wake loop.
> + *
> + * The rwlock is held upon exit.
>   */
>  void btrfs_tree_read_lock(struct extent_buffer *eb)
>  {
> @@ -166,9 +230,10 @@ void btrfs_tree_read_lock(struct extent_buffer *eb=
)
>  }
> =20
>  /*
> - * take a spinning read lock.
> - * returns 1 if we get the read lock and 0 if we don't
> - * this won't wait for blocking writers
> + * Lock extent buffer for read, optimistically expecting that there ar=
e no
> + * contending blocking writers. If there are, don't wait.
> + *
> + * Return 1 if the rwlock has been taken, 0 otherwise
>   */
>  int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
>  {
> @@ -188,8 +253,9 @@ int btrfs_tree_read_lock_atomic(struct extent_buffe=
r *eb)
>  }
> =20
>  /*
> - * returns 1 if we get the read lock and 0 if we don't
> - * this won't wait for blocking writers
> + * Try-lock for read. Don't block or wait for contending writers.
> + *
> + * Retrun 1 if the rwlock has been taken, 0 otherwise
>   */
>  int btrfs_try_tree_read_lock(struct extent_buffer *eb)
>  {
> @@ -211,8 +277,10 @@ int btrfs_try_tree_read_lock(struct extent_buffer =
*eb)
>  }
> =20
>  /*
> - * returns 1 if we get the read lock and 0 if we don't
> - * this won't wait for blocking writers or readers
> + * Try-lock for write. May block until the lock is uncontended, but do=
es not
> + * wait until it is free.
> + *
> + * Retrun 1 if the rwlock has been taken, 0 otherwise
>   */
>  int btrfs_try_tree_write_lock(struct extent_buffer *eb)
>  {
> @@ -233,7 +301,10 @@ int btrfs_try_tree_write_lock(struct extent_buffer=
 *eb)
>  }
> =20
>  /*
> - * drop a spinning read lock
> + * Release read lock. Must be used only if the lock is in spinning mod=
e.  If
> + * the read lock is nested, must pair with read lock before the write =
unlock.
> + *
> + * The rwlock is not held upon exit.
>   */
>  void btrfs_tree_read_unlock(struct extent_buffer *eb)
>  {
> @@ -255,7 +326,11 @@ void btrfs_tree_read_unlock(struct extent_buffer *=
eb)
>  }
> =20
>  /*
> - * drop a blocking read lock
> + * Release read lock, previously set to blocking by a pairing call to
> + * btrfs_set_lock_blocking_read(). Can be nested in write lock by the =
same
> + * thread.
> + *
> + * State of rwlock is unchanged, last reader wakes waiting threads.
>   */
>  void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
>  {
> @@ -279,8 +354,10 @@ void btrfs_tree_read_unlock_blocking(struct extent=
_buffer *eb)
>  }
> =20
>  /*
> - * take a spinning write lock.  This will wait for both
> - * blocking readers or writers
> + * Lock for write. Wait for all blocking and spinning readers and writ=
ers. This
> + * starts context where reader lock could be nested by the same thread=
=2E
> + *
> + * The rwlock is held for write upon exit.
>   */
>  void btrfs_tree_lock(struct extent_buffer *eb)
>  {
> @@ -307,7 +384,12 @@ void btrfs_tree_lock(struct extent_buffer *eb)
>  }
> =20
>  /*
> - * drop a spinning or a blocking write lock.
> + * Release the write lock, either blocking or spinning (ie. there's no=
 need
> + * for an explicit blocking unlock, like btrfs_tree_read_unlock_blocki=
ng).
> + * This also ends the context for nesting, the read lock must have bee=
n
> + * released already.
> + *
> + * Tasks blocked and waiting are woken, rwlock is not held upon exit.
>   */
>  void btrfs_tree_unlock(struct extent_buffer *eb)
>  {
>=20


--AClJMHobbFTMEwAljTo5QKB6DABcMq7QR--

--kF3ImTLbHfIyXBNuzmuLzRnJcXSRWVi7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2pBKgXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgW3Qf+Mm/SMDoGssn1GqTfgznAS5vt
d3Vzpd8WUehcFJIXJdwJEvHSDNFjnpl5C1oh0sC4M2V00U0WZYyZGQ9s7C5uwfe1
brXuNbimFBQ3W9DR39I9XpOkluqwvYOcSfVlfNyohPFvcIA3TH9pz4zscPAdKU+j
yVCS+au2hCxy/7zU4UD2SoTo0o+zDdWIIzl+KbnuL7ouFTY3SCSZUioJN8HuNYW9
BMTCYc7WtlT7G21BMQlz/XYplLIq9NG9DdLVycetADGLqQArTP/jE0MVg76nFD9V
WgLnDgOFE0ACH9IV8MNKKE+xITwNyIvRndC9T0h11+1iuDcBki76CGAS0I9z0Q==
=PWm0
-----END PGP SIGNATURE-----

--kF3ImTLbHfIyXBNuzmuLzRnJcXSRWVi7A--
