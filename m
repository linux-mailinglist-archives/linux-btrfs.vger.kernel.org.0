Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377A9EC0BC
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 10:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfKAJq4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 05:46:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43419 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKAJq4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Nov 2019 05:46:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id s4so9595488ljj.10
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Nov 2019 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skarcha-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zx03BPZrnlPfwcLp0/FDQsqM7WNQkNKcMY7IAFxePH0=;
        b=M3ColGVdp1nGaEHxU4aVwrQLx4Z+ZpDDGNaGeHXwS+bHgyDv1J7nt8Xe4hnaj0CLEa
         F4mdOVeY7JsCz/JnGeVtSoL3SGTLp83DR1fOcgdXyO14V8jHBTJ8il72wGYdONltd8jL
         PBDlH/Gp1j7osN/oPdClOUgt1DDN3xc7rvz+Bj/htXm7TW/OG8cd3MW+CZLSUEI3BVxp
         5wRZfxsavWFggSznDOpIXCMYIqSFEymuohNYougI68iwZl4Te/TaLZwZ7VIk92yAF3So
         REUOIrp36AafDQL4w1jePcKbOWepFT22X8gykAEDVgaK+5q6erOI3mHjR9K52Jg49daS
         ZTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zx03BPZrnlPfwcLp0/FDQsqM7WNQkNKcMY7IAFxePH0=;
        b=Ch852MsQr+4R9Ujg1nRw/biIDKXSRi2Rr9q213qwFO6/OlylJl5kJ5ZQt6xWFrPQvw
         xybX0qAQt7wgkwcnwrt02MwlpdzMdiZVG8XHMPkw/qW+rtW0laqh11Fxmguz7PyTbNlR
         +XoOhXtyMWQ9FFKHJcL+byzsKTO+PujiuUG3xiBVNywQAsD9C57+yO+s9aqIN5TeAwdr
         8NxgFgbU1Ow5wlBctQVi9CNB+hEcY7192j8fskJ5ZKojAe4C571LP5ljA/EIdRA9Bt6o
         dCbVkhTl2HYYd1VvKb1wShhzbP+4bv7QHDgPHTSJ2ygjmHlxtmje5WZEEQezNAPqWZXx
         f+AQ==
X-Gm-Message-State: APjAAAXbi1hkUm+CQfvA5GwB5Qesj5gIzPVQmx4T/HM7YEw6jnye7R9e
        KtsTz18PJi1EHeGtkkgApuDRYWXGEWE0lXLYIVgF58hl
X-Google-Smtp-Source: APXvYqzoaynemKtxcDtdH4sH4+HNNcLtZXn8O8ZE9wMEXt043tr0hucMvLI5YEF7cfynjVTSbVN663nsID2JVS9KsEA=
X-Received: by 2002:a2e:b056:: with SMTP id d22mr7414134ljl.28.1572601613536;
 Fri, 01 Nov 2019 02:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191030084122.29745-1-anand.jain@oracle.com> <20191030084122.29745-5-anand.jain@oracle.com>
In-Reply-To: <20191030084122.29745-5-anand.jain@oracle.com>
From:   =?UTF-8?Q?Antonio_P=C3=A9rez?= <aperez@skarcha.com>
Date:   Fri, 1 Nov 2019 10:46:42 +0100
Message-ID: <CAMhy=vK7HcCHs2JxQUQ5Fyz1CFuAp7erm_2v5ZYY4Ud+BRczZg@mail.gmail.com>
Subject: Re: [PATCH v1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 9:41 AM Anand Jain <anand.jain@oracle.com> wrote:

> +#define HELPINFO_INSERT_QUITE                                           =
       \

Typo?

--=20
Saludos:
Antonio P=C3=A9rez
