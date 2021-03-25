Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EFE349206
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 13:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhCYMaG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 08:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhCYM37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 08:29:59 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E53C06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 05:29:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f12so1459870qtq.4
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZoAi1rW79O1hKnEwlsr29FiP2YMRRJdAq7Mbpf/Cpz8=;
        b=pLc0NKTFYCGTZFS3p/G92D5G8xbfcQaez9aoYH8JY2TDgPHPRDUL41f1P6FM7uOTHU
         s7Rg00c10Zflae53L882wGz00U+daVwIYzEIyc8DiUWX3LBDDUMbG8Y/0EfD8rjLh/AF
         /s6r3Lf98bVRVIAuNJ0h+dD+tiIZOjRT5IRVBTSkbq1FP8iIgrQl2ilal3CDAABm5VQz
         ZCUk1qdMCQYtz6ZgtlCvCMkCL2az2p6vcLBgnEaaEkI2trmlMBBX2JqR/tS7oLVLI4Il
         wWXkQjmzESMREVV4sVxaVRzEwtYMIS/uF1HN+9jYugp4lnYmiW0YKOqkOue7wr2GWbqI
         u22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZoAi1rW79O1hKnEwlsr29FiP2YMRRJdAq7Mbpf/Cpz8=;
        b=O03vz2x3+QrxYWnbUfE9YJmp0CViSfQAEidQFa/zO10T4AchzBBES4nSu6rzJFN3r2
         0pgG4Mc0XZsUW3MO+HpZFrnKG0ZTlII5LIZ8tdxL2ZJYU0s8ukhMS77mIYZ6M/KxFbY0
         9pZ0ME8dV7fdQuNiX92n6FWF+kHH2m/hlm3cBifzlpxCaH44Q61OrOsJOgw3+qVFuRhZ
         h37/muZXM8jx+e0NKyMtG6UOBkQb6xCf4zACHJKzGeCEF1XpdEPNpmzNz6rcQDSSbqjX
         ICmSOCn5VwqacsShpHwLxPuPw8ezgT/etml3Y0VDcOKFq75HvKgU2Qc9GAYvGPVu1c6/
         ss8A==
X-Gm-Message-State: AOAM530tJ6HlwYlTYuwEkDXl9tq5kQh3/yKFtTVL4C71CpiL7cYDRo4s
        FV4zEQTxLSy5v2j26jhQ97rzbc93U33BcY0ySh34MTMD
X-Google-Smtp-Source: ABdhPJxysx44gAeY78v1nPfWfn6MC5k5OIG/R94op1kD4G5Bo/w/o+6KEV9xfWaJZdmJ02tJimzmpbQfYkdGc3c+a2Q=
X-Received: by 2002:a05:622a:48d:: with SMTP id p13mr7372689qtx.21.1616675397729;
 Thu, 25 Mar 2021 05:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGaxVV9q-uOYkDxg6_sU6Z8ZShgg3dpoQYHtfZ-Bra9=vo79EQ@mail.gmail.com>
In-Reply-To: <CAGaxVV9q-uOYkDxg6_sU6Z8ZShgg3dpoQYHtfZ-Bra9=vo79EQ@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 25 Mar 2021 12:29:46 +0000
Message-ID: <CAL3q7H6zUDeqtxR+5fWxGrV9+SQxyVjEdX2eX-+BV3-xsmP7wQ@mail.gmail.com>
Subject: Re: btrfs incremental send failing. chmod - no such file or directory
To:     James Freiwirth <james@perfectshuffle.co.uk>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 25, 2021 at 12:07 PM James Freiwirth
<james@perfectshuffle.co.uk> wrote:
>
> I'm trying to perform an incremental backup as I usually do but I'm
> getting an error:
>
> sudo btrfs send -p /vault_pool/.snapshots/2020-12-31
> /vault_pool/.snapshots/2021-03-20 | sudo btrfs receive
> /mnt/WDElements/vault
> At subvol /vault_pool/.snapshots/2021-03-20
> At snapshot 2021-03-20
> ERROR: chmod documents/Personal/Accounts/ms.txt failed: No such file
> or directory
>
> Kernel details:
> Linux office-server 5.11.8-051108-generic #202103200636 SMP Sat Mar 20
> 11:17:32 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>
> Any ideas?

Pass -vvv to btrfs receive and paste the full output.

Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
