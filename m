Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7153741CD14
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 22:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346138AbhI2UED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 16:04:03 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:57382 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345826AbhI2UEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 16:04:02 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id F3EB4C12FBA;
        Wed, 29 Sep 2021 22:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1632945733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uhwnfm7FGdJ2X1fzJ7L3xdSLvxeTNMz3KuUDMpv1jQU=;
        b=E/ny+w0/vb+GGx8ZVCrQ5o9IX/Zq0JeUBcwE4Dd9ttFJ3ZJf58rnl+TIQmqMAvY3yJCNgE
        aVGKCUez5zUjTGq1tdRa21HDvalbO4CKi8+XDELHOwtqcU6NhQc2YAAfpG5itEGFQOX4+P
        r+I7Xv+k4ZPCiQOGvbUSKrNjlHKTFLQ=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     "B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com" 
        <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>,
        Nick Terrell <terrelln@fb.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Date:   Wed, 29 Sep 2021 22:02:11 +0200
Message-ID: <2877513.20NpC2ByLZ@natalenko.name>
In-Reply-To: <4A374EA5-F4CC-4C41-A810-90D09CB7A5FB@fb.com>
References: <e19ebd67-949d-e43c-4090-ab1ceadcdfab@gmail.com> <4A374EA5-F4CC-4C41-A810-90D09CB7A5FB@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.

On st=C5=99eda 29. z=C3=A1=C5=99=C3=AD 2021 3:30:26 CEST Nick Terrell wrote:
> Sorry for the lack of action, but this has not been abandoned. I=E2=80=99=
ve just
> been
> preparing a rebased patch-set last week, so expect to see some action
> soon. Since we=E2=80=99re not in a merge window, I=E2=80=99m unsure if it=
 is best to send
> out the updated patches now, or wait until the merge window is open, but
> I=E2=80=99m about to pose that question to the LKML.
>=20
> This work has been on my back burner, because I=E2=80=99ve been busy with=
 work on
> Zstd and other projects, and have had a hard time justifying to myself
> spending
> too much time on this, since progress has been so slow.

Mind Cc'ing me on your new submission again please? I'm still running your =
old=20
one with 5.14 and 5.15, and it works flawlessly for me.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


