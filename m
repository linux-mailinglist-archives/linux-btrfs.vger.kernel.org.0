Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483AA679F0
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2019 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfGMLSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 07:18:48 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:39411 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMLSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 07:18:48 -0400
Date:   Sat, 13 Jul 2019 11:18:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1563016725;
        bh=D1rL1pG9RuSkRc0jMNIAM27xnqVtHI4ltzM8BYN87ss=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=Dj5GhrVIHEGer5BKvhXl8FoXgHLWqhkgWkRgOXqrXUnUiPMEBydOojLFC/73HNt4R
         6O4Hm2tm7oU/2F1Is3K/a99+DacPj4S04NOX0rCb0P2HRNWG/lZv1uteDFJliWrexS
         56FfOSvaXvwLPMpHV/+oUX9/bR5pXRJWXTJ+uURo=
To:     Andrei Borzenkov <arvidjaar@gmail.com>
From:   "R. Schwartz" <schwrtz@protonmail.ch>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: "R. Schwartz" <schwrtz@protonmail.ch>
Subject: Re: Should nossd mount option be used for an HDD detected as non-rotational?
Message-ID: <JGPEfVI4qK7tJSXINtren_lHwKz90PTtEuDZg6Et9gj69Nm4ZbeWCtxlOrIZMzGwGymaOWv8UeQUso2kGhowebrKSyMUtKfxQawf_NcoDXQ=@protonmail.ch>
In-Reply-To: <9c872fcc-18a2-0936-f950-f1a74806da73@gmail.com>
References: <htetrjLP1jLMK9WTasfT2e5ZdkY1yV0iY3PHjVEDqCKIZ8d2VwdRTBRezsUAxzKawi_lsxBi5HYfOlvyByGPBwswTCKXSt_lbhRCAmQZ2Qg=@protonmail.ch>
 <9c872fcc-18a2-0936-f950-f1a74806da73@gmail.com>
Feedback-ID: bkDgnfjh8MsvyLj2Q6gYH7gJ_xhppUEW_38zMFhjHmQZrcjU44FunpgrBpP4HWGGznCn-ZE7GYZHi1bYU3WRNA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Saturday, July 13, 2019 11:06 AM, Andrei Borzenkov <arvidjaar@gmail.com>=
 wrote:
>
> kernel sets non-rotational flag according to Medium Rotation Rate field
> in Block Device Characteristics VPD page (0xb1). What
>
> sg_vpd -p bdc /dev/xxx
>
> says?

Block device characteristics VPD page (SBC):
  Non-rotating medium (e.g. solid state)
  Product type: Not specified
  WABEREQ=3D0
  WACEREQ=3D0
  Nominal form factor: 2.5 inch
  ZONED=3D0
  RBWZ=3D0
  BOCS=3D0
  FUAB=3D0
  VBULS=3D0
  DEPOPULATION_TIME=3D0 (seconds)

Hmm, it also says 2.5 inch while it's a 3.5 inch drive.
Could be the connector though, methinks.

(Sorry, resent adding CC: ML)
