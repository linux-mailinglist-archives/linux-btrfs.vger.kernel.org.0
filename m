Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9114170CF8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 02:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjEWAk2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 20:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjEWAKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 20:10:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C419F1BD5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684799144; i=quwenruo.btrfs@gmx.com;
        bh=vW11zk4hf91o+X0yOWL7IvxxMUeEyRqs3pxoNllIAns=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kKjJrlsICCWYY1aZgKqjQrK53SPfM0wXRnIixPgPA8X3dMutiHYP+CInX1np+XSU8
         ZzRcSx71nBfM89iTW56EHAksbjwWtJNyp77ECNNzf2x/61wrsS9QYLek67zrfU7lWr
         ugjKsJyVPkrGI1fHBctYKCkBLji9hq4GNWxn5hLwtTFBnFISOFcVBw8B2aZhVJQl2b
         f6n46Bcc9/cmo56Lnd5SKDwuS5r4VtduEzPDqSiYP4QXidgOByDRoPNEnyNtfaHKhs
         24zhAVTSdDjKCBK0CC1hQmy1f63/nVcNayg71bHLbV8wCbgjaKMmnw5SVFfP1t8+Gv
         wNfBi4mGWibOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95eJ-1qESHI3h5j-0168MF; Tue, 23
 May 2023 01:45:44 +0200
Message-ID: <fce9b483-c6a3-b17f-4c28-abeabf1bfe7d@gmx.com>
Date:   Tue, 23 May 2023 07:45:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 0/7] btrfs-progs: csum-change: add the initial support
 for offline csum type change
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1684375729.git.wqu@suse.com>
 <20230522121416.GN32559@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230522121416.GN32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+wIBtIv7nOKrtW/MgPL/vpY4HtZf6sGUs1wRuQprhTFq2TC1saE
 CaCOCvVz0JquHBEBJJBW0hc1Fl1FgfBeuxdQjbpd3uShAA03FTm2L4ebvCCA3/c1KX084/A
 i+CYG9EKB4Pmr1d5Njl9qclIDhqsd0z4S3r9isE4L3Y4sg/4a/l0XfJIBWKGgBZWRvevnfP
 CQgQoXk7ca6ox92lTiy+Q==
UI-OutboundReport: notjunk:1;M01:P0:vSulFTOSzy8=;o26ey7mzA4rn8PeBWetajQiNpEw
 NRuY78H/dbfycPDWJCNAzZWdtKYBioClQE8oskBpcKpwwWEMtC2xuGHul4kFKYs2y2+d+Tmah
 pV4+gT8tJRMcuPhFqEi9TZTjxuifMTNxZm2TAUZIU+UimK6tMAsqAUiRuMLXuf6AhyOOPVlnC
 tzwzkyixKlNLq3NR3HNOdxFNKT3jqJDi7PEsEyTxIh+muY0YSmpCg0kFKwCu9J4pElw+Y4T5H
 48xhw1spBkSkGYjrAo/ziCOMvDKu0QTAb2E3suWeaqA4XG810CLzywxwJ5ByepZi+85aL8eN6
 FUDH5ftjYJivUDlm+t5MdW3+CEz/qyChnwzYzN0XXdUoQvFWDOzKcMWk64+ZFqbOw1pBKK2vQ
 w/92VLFK/u9TTARt0A08ZjJNpgxzw2v5vxf6Q+Rg/d8VDE8YABxHWPB7LPRzERzgLHfjDci5b
 LKd9P+9KUCcp3PmeL6nbY3GtURhXhV91gzogsH748zPw7MBv5ghVo3A2q9Ai7194cvIL+DdBV
 Ww7D/HK8G4X3TuchNzPqtsgdWEa6jtRX/3CIbBqE2anf2LsIjdQNjhvHkBoPJKIfcG4/o6UmB
 D7YE3t6msDfS3EqVZcRb8UAhYVmoa2SG8gCRoBTMn7VDsX8RLkMUEH0WVOLJVpFmfSdAQOCyW
 yRb2ziBmvPfd693P6JMMp21RzeJutDgNTWXfeweaOYU7djMW90+aiDkWv4lSbxKBgGqlY64J7
 cprEKnJlifR5LMgjaA5an/kYwRAGXmvQyc2+eL+fjabc+Qn7yMKpDSrslevEvjpiTSHIiHr6C
 c5OuctAvNGNUOKlXHpj+cGcnfM41KcfV+8sOnW53DzMYi+U+uofSBX9WVfweKGaAy0lSO9RJD
 MAEdz/NxvQR16TfKe+FaHKCgJAKJieGLuuswzKDQjHvrtCPcsonCh9SQeUmcuXBIxMOF9DMm1
 YwCNeOZKrEXZA6mIHFJjXUjnkA0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/22 20:14, David Sterba wrote:
> On Thu, May 18, 2023 at 10:10:38AM +0800, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Skip csum item checks if the fs is under csum change
>>    Tree-checker can be too sensitive if the csum size doesn not match t=
he
>>    old csum size, which can lead to false alerts on overlapping csum
>>    items.
>>
>>    But we still want the tree checker functionality overall, so just
>>    disable csum item related checks for csum change.
>
> I still see some errors with v2, the same test that rotates the checksum
> types on an increasingly filled filesystem (the one I sent you before):
>
> ERROR: failed to insert csum change item: File exists

Oh sh*t, my tests only do one csum type cycle, which is
CRC32->BLAKE2->SHA256->XXHASH, and moved to the next mkfs.

But your incremental tests do multiple cycles (the incremental part is
not that a big deal, as after a full conversion it's no different than a
new fs but filled to that state).

In that case, even my v2 patches forgot to delete the csum change item
in root tree.

And one cyclic run won't fail, because they all have different offset,
but multiple cyclic runs would fail as long as we hit the second time
for the same target csum type.

The only thing saved my backend is the detailed error messages...

Thanks,
Qu

> ERROR: failed to generate new data csums: File exists
> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D16384
> extent buffer leak: start 610811904 len 16384
> extent buffer leak: start 5242880 len 16384
> WARNING: dirty eb leak (aborted trans): start 5242880 len 16384
