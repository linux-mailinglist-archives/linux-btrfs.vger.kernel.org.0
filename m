Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA6754DF1
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jul 2023 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGPJCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jul 2023 05:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPJCi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jul 2023 05:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1E2D1
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jul 2023 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689498110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ior1LwIUvl6lmQWns59as31BxZ8x5tykCT3ciFG9/Go=;
        b=TESL7HAdkQBwdFMjAP9+zRQj8NB+KntykXCmlI0Cju6GqLePucZxRC7ibLmaVpdtc8hRck
        B8CojjeLe+zn5Ul9PmASuiQdKtgOvnwDi7UY1cnpEHPCZdA/Q2/14myQkJsgkU3i2LZ/w0
        DLUsdDN8jiu7QcDENvad5wzjmE1RYx0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-qvWt1G_kNOae1dZxR0v1hA-1; Sun, 16 Jul 2023 05:01:49 -0400
X-MC-Unique: qvWt1G_kNOae1dZxR0v1hA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B22AF29AA3B4;
        Sun, 16 Jul 2023 09:01:48 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 036E92166B2B;
        Sun, 16 Jul 2023 09:01:47 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Neal Gompa <ngompa13@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs loses 32-bit application compatibility after a while
References: <87cz0w1bd0.fsf@oldenburg.str.redhat.com>
        <f393fcb9-2d8b-e21e-f0fb-d30cbbb1ed3b@libero.it>
        <CAEg-Je8EGjyX3CCcAywy7K2osGAj36T_Cbz5+VXfy4XbcemJ4g@mail.gmail.com>
        <b332fcc8-b060-8646-775f-f4b52f0363d7@inwind.it>
Date:   Sun, 16 Jul 2023 11:01:46 +0200
In-Reply-To: <b332fcc8-b060-8646-775f-f4b52f0363d7@inwind.it> (Goffredo
        Baroncelli's message of "Sat, 15 Jul 2023 11:30:15 +0200")
Message-ID: <87edl85ix1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

* Goffredo Baroncelli:

> On 15/07/2023 11.09, Neal Gompa wrote:
>> On Sat, Jul 15, 2023 at 4:32=E2=80=AFAM Goffredo Baroncelli <kreijack@li=
bero.it> wrote:
>>>
> [..]
>> It was somewhat common for Fedora users. A number of Fedora 32-bit
>> ARM
>> variants used Btrfs until 32-bit ARM was discontinued in Fedora 37[1].
>> openSUSE still has 32-bit ARM and x86 support in Tumbleweed.
>> This issue is also possible on 64-bit x86 systems where 32-bit x86
>> applications run on it. That's what this report is about. We're
>> hitting it in Fedora because our 32-bit x86 builds in Fedora
>> infrastructure run on 64-bit x86 environments and triggered this[2].
>>=20
>
> From what you wrote, it is seems more "it is technically supported" but n=
ot
> big users. Otherwise I expected that a lot of bugs or complaints happened
> when it was deprecated from 5.9 and removed in 5.11.

I think that for most users, it will take some time (years?) until they
hit this issue.  The builders are a bit of a special case.

This is something where telemetry really could help.

> Despite that, I am curious about what could happen when a 32 bit
> application tries to access a 64 bit inode: does the kernel return only
> the lower part of the inode number ? How this is handled in
> other FS: what happens when an fs hosts more than 2^32 files ?
> Unlikely but this may happen. BTRFS makes this more easy to happen.

The expectation is that the kernel interfaces return EOVERFLOW, the same
error code that is used for file sizes that cannot be represented using
the 32-bit interfaces.

Thanks,
Florian

