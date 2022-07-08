Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E190656BA09
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbiGHMsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiGHMsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 08:48:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2C73922;
        Fri,  8 Jul 2022 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657284456;
        bh=2oifC1piO8UrA5RD6gRdN5bklPa6gY2fh5BSHJmbwxI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gY1zx0EzZhRpeFKj2v6WyGFl44GFcPeiRc006HBcMP8J3NVqHYZ5Xs46WeKGlJyPo
         OONBRczA7wqQQVJTSkY6KTfkeZSfv2ukD6B+bV5lh3kf6n+QFpJtm2K3OlbAFTf1y8
         AcnwpNatfUdsx6AKKztLUiLRgvFLgpmFcIFqadYc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.171.120]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1o4tp000dC-00YfQI; Fri, 08
 Jul 2022 14:47:36 +0200
Message-ID: <a665668a-4a10-d39e-d879-7f43aafad333@gmx.de>
Date:   Fri, 8 Jul 2022 14:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/2] highmem: Make __kunmap_{local,atomic}() take
 "const void *"
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <20220706111520.12858-1-fmdefrancesco@gmail.com>
 <20220706111520.12858-2-fmdefrancesco@gmail.com>
 <20220706120712.31b4313f17cb7ae08618c90e@linux-foundation.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220706120712.31b4313f17cb7ae08618c90e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mxaLCL8eT7tSvJnbIMGyZhGv6tob6iP9FCVQevHsK9zdzyMY+LV
 f/cNx/A9qwklApoQaPBkepG+YxURZwrf10v/sf77ErAtg1z0vmEDVeZSaqmj+x+bIa7vsnN
 iv4nzt/Ht+4cfiRu9XLCcq29qabamyXOs0/qydsVdroxagQvO4VAYeBTlo6p1zdPJ48MuX7
 vIx3z5DeNODaOqp/EQGuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k0uTu86fgK0=:rSa2j3/Xwq0fb+19DZDIbQ
 FbNfrrTpSNR4BuG9FxPHFpskMQOj9z/NpeTY2u9wFCl36L1y5xOsrpbX/A+x35Q5BDkv+hgZZ
 r84rhu6btQtT/flkWnrlkE9W3IYPksptQJylHTzVy9eO/hgIAUpVhOqwrHfzZndyhvh4mqo8u
 WnWNfsQLtfVoIugwOpF6qwNc4yDPdfv1ncv+JIgXCzXmfgOWgb3RI1PvTYWQtQQI1o2glzA93
 ByyFBe8YclOTPxV7c4M8f2P7+DtyTebzdZ63gjPURxz0KnoBtZgg/kihQB/wM6R2DnwPu8cEX
 sjK+KNSQpfOef6lZR3dI4TIBgTaNYMn7J/5RzVzof49w3HpnM6QIdjXbRumoy2kUFkzPFAuNV
 aT6DXE1t7EzfCdASbXgCynwD/HfwfiCNlDzBFRM2FzeLdk8oFJ1cPnsoeDgTnWYFI4H1Dn4YW
 ubY/vUD2SnrEOZQUzIYTj/7QvTSqm/P6oiDidgKxiB2Zea5sb/0Ful0rL2TwzB44/KdWcZJcL
 gn4MRCoCxY329Opg9F4Ppt3ZwodJHj9Lu3lTb8SmoC0RoWTzW8mfj4MCDzJPF67x9ZS5xsLI/
 mw69TL+ZRbnVotnaorcEwj8DkgfhrewdkDBL9n45hX/zVTsiDe03HKHLG8rLCeqKJC3oPQyvn
 LGJGKawd4jNowIlDsNO1oUAqumDrhBCz5wdTgI/9SAHJapkjRcsi4hKs1jvEWkTxR6+2/IlgK
 BMrE1C3ADfNXH8eDDg5y67rDpASMd2hEAjYcJFcQb9p0rL4PgZFbVR+dudwHaH6ReCJL2BTBa
 9mARIcEdzGEvnRgqP/PG9EVKKdkjlrzaEJszVsXIIIFMnA+Q1o2hNoJIwTm09EFuv8puAVLgn
 SpHCZqpFoyx+6vlpJJYYJPgAJXwy6yqIEHVxmg20SzjYCcH4n9e0/Ik8VTu94LP3yGwXuObNP
 JE8rS8FQGdXFiWUQHM6xkJmqF5482OfLubW3B/U6w2r93PDegp/Uk0K5OzUkzHluHMesBaFFA
 tshXCGJhhFp2vYLH4bAwxG3g7Ort30TgjWUner7hYcWtoay/dwC32o98xyHafIS24vxr5StHb
 8mWFazgIKvmvYklLTDOeD5fENvAVPIFct7hrmJY3aKV1vs2e/JWH8u87A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/6/22 21:07, Andrew Morton wrote:
> On Wed,  6 Jul 2022 13:15:19 +0200 "Fabio M. De Francesco" <fmdefrancesc=
o@gmail.com> wrote:
>
>> __kunmap_ {local,atomic}() currently take pointers to void. However, th=
is
>> is semantically incorrect, since these functions do not change the memo=
ry
>> their arguments point to.
>>
>> Therefore, make this semantics explicit by modifying the
>> __kunmap_{local,atomic}() prototypes to take pointers to const void.
>>
>> As a side effect, compilers will likely produce more efficient code.
>>
>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Helge Deller <deller@gmx.de>  # parisc

> Please include this in the btrfs tree if/when [2/2] is added.

Yes, agreed. Please take both through btrfs.

Helge
