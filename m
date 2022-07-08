Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2442E56B2A4
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 08:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbiGHGUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 02:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiGHGUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 02:20:16 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB83E2409B
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 23:20:15 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e7so483687qts.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Jul 2022 23:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ZdyLZLrUEnHgAXwhYOQn7srv5AQGXacjIg1FqDFgS6M=;
        b=U1Fd9eWrTuh0zy5LSPFhu+fRh/FzgzPgPHVDXm9AHrwgag59jBjzTbnRhOAJbrXw6+
         saPgKwrJwup6RnnRC7FZL2eV1JAjM9IaQdXo5R9uSJxAX7uxoAZg/C6TJJzLKs3eXF1q
         CVClLorycx9CQ0YMjzi7p8MUgyNonkSzRQv9gfwGk71cWfIJKd50W4YX5dHTP/XN9v5u
         kAq1e76n9eWIO7lIF8q6dp0H5+mEuO+ZcodjHHPXckG3jzl4vuvqwNPuK+jbErTY5ado
         nxUrTTOr+C0KKYQWPZD9q3VK2u3tyD5vA65CgxcRLzSlITwpAbiTo10B8bio66VMoFAD
         6eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ZdyLZLrUEnHgAXwhYOQn7srv5AQGXacjIg1FqDFgS6M=;
        b=Yh6nfJsbzt3QTENqiMslSjN0iCe0enUlSlUieWnt3RQf69ShFFf9NJjRjbvTGMGrzJ
         uBHRH21pyyZ2v9FfnwrgbgJ6lWOOizGxKTbxShLRuL/cKDUFUcYveWJGGxtS1NhZNyMW
         hZ3rGsS5yX2bN5MFpUshgErdh8MY18WhCPni+m2+zUbhRFhb9hmfChos/XC3pam8hvdJ
         Moy62wqhbnAGhk9h1SqoLvWpDNjNbW3oyXr8Xc3ThqMtbn+wryQpMCOMqSlLDC47smjt
         sX03wVGB0uEMY9w+Kv7THNgSmXkthXKgOQam0nZqFqw+Fia7YtkzNx6tnQD0RLS1XLCX
         ME7w==
X-Gm-Message-State: AJIora/hbwLz8XUwl3wu+eQ9Eof6DOo0zkfCQIPMGzvjPJsRmc0biNZP
        2ZqT8CoajqI6/LCsCP5dF1s+CvPlAZQ=
X-Google-Smtp-Source: AGRyM1seBkkldltBcCwK+vc/E0RX1P0t1peAptEiJL7/Db/IyHcs7FbSdTnQLsVifSDA9MD2LWnhwA==
X-Received: by 2002:ac8:5b93:0:b0:31d:348a:3cb with SMTP id a19-20020ac85b93000000b0031d348a03cbmr1510567qta.357.1657261215005;
        Thu, 07 Jul 2022 23:20:15 -0700 (PDT)
Received: from smtpclient.apple (modemcable117.130-83-70.mc.videotron.ca. [70.83.130.117])
        by smtp.gmail.com with ESMTPSA id o12-20020a05622a138c00b0031e9fa40c2esm2505941qtk.27.2022.07.07.23.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 23:20:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Denis Roy <denisjroy@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: BTRFS critical (device md126): corrupt node: root=1 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896 should be aligned to 4096
Date:   Fri, 8 Jul 2022 02:20:14 -0400
Message-Id: <BD6F70A8-17FB-40E3-87DE-E185049DEA2E@gmail.com>
References: <1d43c273-5af3-6968-de18-d70a346b51aa@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <1d43c273-5af3-6968-de18-d70a346b51aa@suse.com>
To:     Qu Wenruo <wqu@suse.com>
X-Mailer: iPhone Mail (19F77)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok, great. How do I do that?

Sent from my iPhone

> On Jul 8, 2022, at 2:01 AM, Qu Wenruo <wqu@suse.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 2022/7/8 13:50, Denis Roy wrote:
>>     key (7652251795456 EXTENT_ITEM 72057594063093760) block 1256710125472=
0864896 (383517494345729) gen 72340209471334675
>>     key (2959901138859622420 EXTENT_CSUM 3664676558733568) block 22340668=
86193184768 (68178310735876) gen 18374696375462128179
>>     key (1153765929541501184 EXTENT_CSUM 0) block 0 (0) gen 0
>>     key (0 UNKNOWN.0 0) block 0 (0) gen 0
>=20
> The above dump shows the tree node is completely corrupted by some weird d=
ata.
>=20
> The offending slot is not aligned, and its offset (extent size for EXTENT_=
ITEM) is definitely not correct.
>=20
> But the offset looks like a bitflip:
>=20
> hex(72057594063093760) =3D '0x100000001800000'
>=20
> Ignoring the high bit, 0x1800000 is completely sane for the size of an dat=
a extent.
>=20
> The next slot even has incorrect type, (EXTENT_CSUM) should not occur in
> extent tree, but this time I can not find a pattern in the corrupted type.=

>=20
> The offset, 3664676558733568, is also not aligned but without a solid corr=
uption pattern.
>=20
> And finally we have an UNKNOWN key, which should not occur there at all.
>=20
>=20
> So this looks like that tree node is by somehow screwed up in the middle.
> I don't have any clue how this could happen, but considering the checksum s=
till passed, it must happen at runtime.
>=20
>=20
> For now, I can only recommend to go kernel newer than 5.11 which introduce=
d mandatory write-time tree block sanity check, and should reject such bad t=
ree block before it can be written to disk.
>=20
> Thanks,
> Qu
