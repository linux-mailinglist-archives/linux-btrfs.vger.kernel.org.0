Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826682218C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 02:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGPAZH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 20:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPAZG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 20:25:06 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757B9C061755
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jul 2020 17:25:06 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so3208767edb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jul 2020 17:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rvWkNovixiK7Ny3rRBHkPW7eK/eStwZ3tJFAPT/wTj4=;
        b=B6zLbFZPQDUyw0M/Q+PgM3U6sbbZEiEHWfmYHmbWbAp5ONsPHGXoW+MyQIIwNxUj6Q
         Vr4prxcKBhHJIAa/ODkAX93kcsuYZZwL1FLaAfn++oVI+qlHIjKHV0CZob1fAVSq58y6
         9zlAf/4xGex9nCmfR36pS8BAjgqIsHiMr/7mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rvWkNovixiK7Ny3rRBHkPW7eK/eStwZ3tJFAPT/wTj4=;
        b=dcWBEG0Gfkj7/oJFxysbVuVhQcsVn36n0Y43VFyi4+5PxAhvcyUo/ysHev5Zl2JSbz
         IVNDZy/XIs1Ya4BRp6mOXAksRsxplDt7CUIL6AMvWzyoF6siIx7zpNUK38XVvAx6BuB8
         NMYJM7gUlxFvlDH2s2Y+vB6hZFAhp0rqLVKno2+7BN8fz4SlRTXBYHSELBt7yf0KWv+y
         2uGhY0J8ZcZjS9eteCcLRJka4fzdPUZGUa9DIFiNMi8eYP/m6k6CO5Yrge087xm97lOD
         xHpkF4/RxHmCxufvsWrqEWZubuR3AtbcqFExPPIfqQztS9BYISTHfxqcb1DsgtVe7FT1
         Ev7Q==
X-Gm-Message-State: AOAM532ZYn5chmDM34Qd8WduOGHo6oXULdLNc2dxzUfI8YvsCDBFTCVy
        1sKgGKsXdN2OmDqyHklQ2uG9URmjSNvbug==
X-Google-Smtp-Source: ABdhPJw4VrFGqBQ+Q5/Ol8gSre5yO1DUlU9GTA1JljzqdNy8g3DdwqPZYCoWU6SnVF0eOtRt3jrdvg==
X-Received: by 2002:a50:f149:: with SMTP id z9mr2072658edl.167.1594859103294;
        Wed, 15 Jul 2020 17:25:03 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:a5b1])
        by smtp.gmail.com with ESMTPSA id o18sm3454215ejr.45.2020.07.15.17.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 17:25:02 -0700 (PDT)
Date:   Thu, 16 Jul 2020 01:25:02 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200716002502.GB2140@chrisdown.name>
References: <20200715134931.GA2140@chrisdown.name>
 <e973ae45-c746-95b7-d176-180d47ecb2e2@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <e973ae45-c746-95b7-d176-180d47ecb2e2@gmx.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Qu Wenruo writes:
>On 2020/7/15 =E4=B8=8B=E5=8D=889:49, Chris Down wrote:
>> While testing my pending patches on top of linux-next, I encountered a
>> bug that seems related to this patch during btrfs unmount. Specifically,
>> a null pointer dereference in kobject_del inside btrfs_sysfs_del_qgroups
>> from close_ctree.
>>
>> The fix may be as simple as checking if the kobject is initialised,
>> although perhaps it should always be initialised in this case, so I'll
>> leave you to work out what the real issue is :-)
>
>Thank you very much for the report.
>
>May I ask if the qgroup is enabled? Or qgroup is not enabled at all?

I have quotas disabled, so I assume qgroup is also implicitly disabled.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEECEkprPvCOwsaJqhB340hthYRgHAFAl8Pnl5fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDA4
NDkyOUFDRkJDMjNCMEIxQTI2QTg0MURGOEQyMUI2MTYxMTgwNzAACgkQ340hthYR
gHC+dg/+JOnKCxtDLccDz13LRBKHG4jdngN+4+X2FyYmnvV1/T+GcckqTg3zqWOP
Xec5+MLCFvAaQbxk2OjwhZaVYWVROOZeoYoDh2vyqFxqtoWrdSVqoMPhGElWpnBO
cSVNbWTTbtsyx4xewYoagG2+oUVU3OdMzHDe020AW0akz7dvWF7wh6DaIidcEhW8
tuWSWQgRpL5/ju2zXwkknvdyuw5jl9eo2wLw3b43T8ejUj4zjkDtQ1d6aMVRuHg9
ZCfVofat7acSTSkXoO0Upu8LqaPB1XOpVE5rt+U4bO6UWUj/01r0zh9Kt9xy+XzT
l1Bn7Dom/NdZDremfAsdD2jUsWr4aY/BwfvR7tC4FdWTKbvA/EWbS+9pb4MzCDZ7
7u1bQmvnY4HD14zLArDXSA/nCGzM3xpCodhP7NYN5+JRSpb8oioBgOg7ct2Rfwyu
tFbrLfmRqgZ7SbKRiHUFrGGyQPT5eSNOGo+DLgsAmokoZXjGmcUDOBp1PTsoR9gR
vLUpxAt885cNfwO6SBDWyqnyYJzHFhipoxFw++4ksvKfVpKuB6BXVIeLHcUz0mny
LLaEAzWuKRu6/nYTHAPt7LwNlh/lKNIxRAEs4KTFL3Uo4GF8pGJlLyjzOuZwJ31L
zlt4oaqVUgSZLw5yS/wqH134v+IhXw3XDs2BLonkMprxdmYGQrI=
=Q+gm
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
