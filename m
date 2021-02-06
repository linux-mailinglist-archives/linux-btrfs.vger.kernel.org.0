Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257C6311DB7
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Feb 2021 15:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhBFOhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Feb 2021 09:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhBFOhJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Feb 2021 09:37:09 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF4EC061756
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Feb 2021 06:36:29 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id d20so10738732oiw.10
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Feb 2021 06:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=gHpg/EPVa3o65RxgJ93Dz4FsLimYxfPncA7a2KVCOQwfvvsopgfCoqbGZ3OasuDtBY
         NLaQ5/frJj5h2jUjGBBJEzaWoP2oO6/7hrQkWhLl+5EeYdY1YwYTV+qr/jcGShOxUfub
         9E6NngAQD+fMrFXDOTbE4lLu2U7SAW1Elxrfe/Nr1URYUHlfBs8WhANRFcWM6fuVVQxH
         x7WS+h4ADL1cTauhB3VSQd+Nq08/6sgSHVBcN8f5j9IAhiJ5wNhdGIQu1zdgn3TYRX0s
         9R0YuDxga+2YbnvpgRs0g2ub6wmafsaWw/5rV/WlV0TiEAzZENWPk+wOZ6eQxtRufx9J
         CPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=H5OV8ihEHojinVpbLlsqZNF/c1ze6Spp/9Myn+9Tbnr5bPup4lBnBSzb3VfN53bWMD
         AY6/JpDLoRRFTLt3Utou/jfDR02NRWYzmShyiQ+02k+LKAUj3ywZkfI2OPS4WvvHktQk
         1EL/JhfUXS3uAN2KmYMf9qHdI0qr50hMlAHMAvlmKTTvbAH7KzHwo84zyjX7IIFD+Qxp
         tbA8nKqvJxKWKh+PYTyF4DzLLRylsLqPGln1DBiRjd3pOojLevajIJpALfAClFcu3dxP
         PR/46XGZXMabLbSBB/GYKoMv2ggw3HbjsErS/1tQXpTMkjM40dFpD2DVL15C1TAPdTIZ
         7tog==
X-Gm-Message-State: AOAM531P2BSUjIp9BWTZySS2kfeSUEAF+nexhbahs4oYZis7ET3tuFV+
        S4sVt9lmIz4lPWXLB5H/WScfx4YwQN6IFq8S6ZQ=
X-Google-Smtp-Source: ABdhPJxxOkZ9eesacHgFT16nNuNsQv0hUyTQOKzDpKw383+60c+4v4cLHAWYmj3m8Pi3iOPWdpWUgdSl8/8QKjZ03zg=
X-Received: by 2002:aca:d4ce:: with SMTP id l197mr6047804oig.36.1612622188580;
 Sat, 06 Feb 2021 06:36:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:36:28 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:36:28 +0100
Message-ID: <CAO_fDi_zRL0RZsSMJLO0kYQQR8Q-LoDSYrtGDk0k=aEez6w44Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
