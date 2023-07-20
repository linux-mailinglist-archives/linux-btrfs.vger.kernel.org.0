Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4075AAB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGTJ2W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 05:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGTJ1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC21FD21A;
        Thu, 20 Jul 2023 02:13:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 859D922AB3;
        Thu, 20 Jul 2023 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689844408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iP6j6uzagV9FuXkcBI9uezemv6R6B13It0TrmbQfh8=;
        b=dZ2nHFPDUK8f8khPs5+fQqjrnPzgzyMGfLtxQggE+3R9KBBfC8hRK913vTu6CHYpJiz9NL
        tCdRmPTp38+1EPukfRS/m+CF9XcsXGdd0cuQvPuOP/UMosw0/FkqSyWRY/L9f57paUYdvi
        TA5edvniHwI5V4CUedYUahbTi7Uzln4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689844408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iP6j6uzagV9FuXkcBI9uezemv6R6B13It0TrmbQfh8=;
        b=yxf3qPczokZtj2qFDi276Sz2s08gs2O6G5gQsNsjWttWqLMMwB4W8YXvLaXvzh3oZVf5ER
        478H63dMxF59VBDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BFE4133DD;
        Thu, 20 Jul 2023 09:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PeBmO7f6uGSOPgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 20 Jul 2023 09:13:27 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 715c985a;
        Thu, 20 Jul 2023 09:13:26 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: turn unpin_extent_cache() into a void function
References: <20230718173906.12568-1-lhenriques@suse.de>
        <7f2db85d-5090-8614-adae-d0ee64a26ec6@wdc.com>
Date:   Thu, 20 Jul 2023 10:13:26 +0100
In-Reply-To: <7f2db85d-5090-8614-adae-d0ee64a26ec6@wdc.com> (Johannes
        Thumshirn's message of "Thu, 20 Jul 2023 07:12:58 +0000")
Message-ID: <87lefbvtc9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Johannes Thumshirn <Johannes.Thumshirn@wdc.com> writes:

> On 18.07.23 19:39, Lu=C3=ADs Henriques wrote:
>> The value of the 'ret' variable is never changed in function
>> unpin_extent_cache().  And since the only caller of this function doesn't
>> check the return value, it can simply be turned into a void function.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>
> Hmm but inside unpin_extent_cache() there is this:
>
>
> 	/* [...] */
> 	em =3D lookup_extent_mapping(tree, start, len);
>
> 	WARN_ON(!em || em->start !=3D start);
>
> 	if (!em)
> 		goto out;
> 	/* [...] */
>
> out:
> 	write_unlock(&tree->lock);
> 	return ret;
>
> }
>
> Wouldn't it be better to either actually handle the error, OR
> change the WARN_ON() into an ASSERT()?
>
> Given the fact, that if the lookup fails, we've passed wrong=20
> parameters somehow, an ASSERT() would be a good way IMHO.
>
> Thoughts?

OK, I guess that using ASSERT() makes sense -- it's used in several other
places where lookup_extent_mapping() is called.

Returning an error to the caller can also be done but I wonder if the only
place where it is called actually cares about it.  That's in
btrfs_finish_one_ordered(), and it basically does:


	if (test_bit(BTRFS_ORDERED_PREALLOC))
		ret =3D btrfs_mark_extent_written();
	else
		ret =3D insert_ordered_extent_file_extent();

	unpin_extent_cache();

	if (ret < 0) {
		btrfs_abort_transaction();
		goto out;
	}

Even if unpin_extent_cache() would return an error, I'd say that it is
better to try to proceed anyway rather than abort if unpinning an extent
from cache fails.  But my opinion isn't very solid ;-)

Cheers,
--=20
Lu=C3=ADs
