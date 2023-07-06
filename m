Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8F7495FF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 09:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjGFHFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 03:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjGFHFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 03:05:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD5E65
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 00:05:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6993ef4f2so728721fa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jul 2023 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688627112; x=1691219112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/1mk0z4eg1p5Ext6AeE1qdkPQacMS2kyp1KjDo2/qQ=;
        b=NpkdLOsyVp37RZpnZZ7Z5sg/WmJkUVoQu9Raq1T/8bIUhuruHZ9vVN6tTlA+ADyy6l
         Fw05k2IWLibkA9wmYE/t/ZWpnQ6kPDLCAgE/CcNHYmC9Y2VGRjI9g5M+naDAQg+ALOwt
         JmSwwWAtvc+ns6LYKw73dCPjFIveWnVn9s/m6559VJxUe6UWkYs3ezzMbfT2TPtWpRwb
         OOiBXIudQiiLJAC+iXEfHOOxAUewGsLWDBVBwQwJfYxXBW/mWh3OJcXXkFR6JMYgfvS3
         DxV921rvSIsz1rBTf9RKSwCvKKIOz/wWfHu0dauvJMQ3caJBk+LsqkDzyoH82DuhCghb
         h0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688627112; x=1691219112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/1mk0z4eg1p5Ext6AeE1qdkPQacMS2kyp1KjDo2/qQ=;
        b=Jb2sYHzvizDRzMDWpyLmnKI76To2RUWMYa679g/MsTdF51/MysQ8Y6CmLVcMXl1Afz
         71keqrIPFzlH3dznokeN9xynEl5mmfjrHgen4WxRL+bCwFzmpPS2zhcSaxhTfcagSUns
         zKYkVARNYsBMXYU/jFaqwy8foGP28aO0AtW3fYdBSFhFFzOXMgoHvmsso2hKU7PPylCr
         E6OMDdhvaU8i8EcNzqm+BEzbOncQyB1Y373zzfLYvUFUTwyrRA+pVbrsxKI6kIfTATbh
         Op0WTlezvIpFQonV+FAW2yC6s04XtLCs8Sbx4c+3oI/lX2rQgnwvwZwVtmBPzhx8K5i7
         hbDw==
X-Gm-Message-State: ABy/qLbRM9dPbXHjpKy9xf83hdxmvN4btmt4muphMZGgfmpgfR/2Y2SJ
        FYWjakEp67/V4AzcgmQAdZci4gdITj2fiKBJSBEkogwx
X-Google-Smtp-Source: APBJJlHJ2g3nm+3mSNecfBIBYMoMCahs9TY6KnMqD/wg0kitiS2EuR44KWr8CfdJSMDthZaME+DPX1L7EptO+87Y884=
X-Received: by 2002:a2e:a4b1:0:b0:2b5:ef16:d393 with SMTP id
 g17-20020a2ea4b1000000b002b5ef16d393mr396844ljm.3.1688627111422; Thu, 06 Jul
 2023 00:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com> <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com> <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com> <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com> <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <11a9ec6a-7469-fdba-4375-c24e8ea5f7fb@gmx.com>
In-Reply-To: <11a9ec6a-7469-fdba-4375-c24e8ea5f7fb@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Thu, 6 Jul 2023 10:04:59 +0300
Message-ID: <CAA91j0VjUiXZJi=S2h7uox8sL3B84yNSw+9SLiL0AxntO3TDDQ@mail.gmail.com>
Subject: Re: question to btrfs scrub
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 6, 2023 at 9:22=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
> In your case, since you're already using LVM, thus I believe the fs is
> using default profiles (DUP for meta, SINGLE for data), thus there would
> be no extra copy to recover from.
>
> So there is really error detection functionality lost if go nodatasum.
>

You probably mean, "error *correction*". Error detection will
certainly be lost. And error detection is certainly useful to detect
data corruption (that is not usually possible using traditional
filesystems). Yes, it will not be possible to correct these errors on
btrfs level without redundancy.
