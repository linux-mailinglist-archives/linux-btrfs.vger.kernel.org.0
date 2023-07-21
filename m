Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FF875C257
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGUJCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 05:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjGUJCa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 05:02:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C62D4B;
        Fri, 21 Jul 2023 02:02:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75DB921979;
        Fri, 21 Jul 2023 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689930147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVcf7rz5f+9m6sax0l/1jeoGOzJiq/lgITLiq23Ep8I=;
        b=YjgTeflsWpVpeDGeqjDN1A1y/XFatnIBbOINNpk6SnD8DIOWAXKO7ofjWUUm4XaMZA/fAZ
        TFqUUrPK6Ug86vItsxn73no0E+JVPX1AScMXt8WsrUah+Z9YilK3lujTM8qjgQaKU8eKrH
        R77iM7kuonJstc6Vo2izWW/uVyNEb7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689930147;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVcf7rz5f+9m6sax0l/1jeoGOzJiq/lgITLiq23Ep8I=;
        b=Hi8StsxebSUS3i28sfFufYxpzMBJxd2okPmcyNY7kl6GnLDoWTLkV6rrBYCVZWS1XdVdU2
        igjm8HkdwAcVwpDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8E17134B0;
        Fri, 21 Jul 2023 09:02:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rsTANaJJumTeZAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 21 Jul 2023 09:02:26 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a18f298f;
        Fri, 21 Jul 2023 09:02:24 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: propagate error from function
 unpin_extent_cache()
References: <20230720134123.13148-1-lhenriques@suse.de>
        <CAL3q7H4uqXttKMCucHH=tJDYkxOFuNRGR04ZSBD7eBMj4BE1iA@mail.gmail.com>
Date:   Fri, 21 Jul 2023 10:02:24 +0100
In-Reply-To: <CAL3q7H4uqXttKMCucHH=tJDYkxOFuNRGR04ZSBD7eBMj4BE1iA@mail.gmail.com>
        (Filipe Manana's message of "Thu, 20 Jul 2023 17:15:13 +0100")
Message-ID: <874jlx1vtr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana <fdmanana@kernel.org> writes:

> On Thu, Jul 20, 2023 at 5:05=E2=80=AFPM Lu=C3=ADs Henriques <lhenriques@s=
use.de> wrote:
>>
>> Function unpin_extent_cache() doesn't propagate an error if the call to
>> lookup_extent_mapping() fails.  This patch adds an error return (EINVAL)
>> and simply logs it in the only caller.
>>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>> Hi!
>>
>> As per David and Johannes reviews, I'm now proposing a different approac=
h.
>> Note that I kept the WARN_ON() instead of replacing it by an ASSERT().  =
In
>> fact, I considered removing the WARN_ON() completely and simply return t=
he
>> error if em->start !=3D start.  But I guess it may useful for debug.
>>
>> Changes since v1:
>> Instead of changing unpin_extent_cache() into a void function, make it
>> propage an error code instead.
>>
>>  fs/btrfs/extent_map.c | 4 +++-
>>  fs/btrfs/inode.c      | 8 ++++++--
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>> index 0cdb3e86f29b..f4e7956edc05 100644
>> --- a/fs/btrfs/extent_map.c
>> +++ b/fs/btrfs/extent_map.c
>> @@ -304,8 +304,10 @@ int unpin_extent_cache(struct extent_map_tree *tree=
, u64 start, u64 len,
>>
>>         WARN_ON(!em || em->start !=3D start);
>>
>> -       if (!em)
>> +       if (!em) {
>> +               ret =3D -EINVAL;
>>                 goto out;
>> +       }
>>
>>         em->generation =3D gen;
>>         clear_bit(EXTENT_FLAG_PINNED, &em->flags);
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index dbbb67293e34..21eb66fcc0df 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -3273,8 +3273,12 @@ int btrfs_finish_one_ordered(struct btrfs_ordered=
_extent *ordered_extent)
>>                                                 ordered_extent->disk_num=
_bytes);
>>                 }
>>         }
>> -       unpin_extent_cache(&inode->extent_tree, ordered_extent->file_off=
set,
>> -                          ordered_extent->num_bytes, trans->transid);
>> +
>> +       /* Proceed even if we fail to unpin extent from cache */
>> +       if (unpin_extent_cache(&inode->extent_tree, ordered_extent->file=
_offset,
>> +                              ordered_extent->num_bytes, trans->transid=
) < 0)
>> +               btrfs_warn(fs_info, "failed to unpin extent from cache");
>
> Well, this is not very useful. It doesn't provide any more useful
> information than what we get from the WARN_ON() at
> unpin_extent_cache(), making the patch not useful.
>
> This warning has actually happened a few times when running fstests
> that exercise relocation (not sure if it's gone and accidently fixed
> by something recently).

Oh! In that case replacing the WARN_ON() by an ASSERT() would have
definitely be a bad idea.

> But to make this more useful, I would place the message at
> unpin_extent_cache() with useful information such as:
>
> - inode number
> - id of the root the inode belongs to
> - the file offset (the start argument) and extent length (or end offset)
> - why the warning triggered: we didn't find the extent map or we found
> one with a different start offset
> - if we found an unexpected extent map, dump its flags (so we can see
> if it happens only with compressed or prealloc extents for e.g.) and
> other details (length/end offset for e.g.)

Thanks, Filipe.  This all makes sense.  And in this case I guess I should
go back to the initial approach of changing the function to a void
function, but adding all this useful information.

Cheers,
--=20
Lu=C3=ADs
