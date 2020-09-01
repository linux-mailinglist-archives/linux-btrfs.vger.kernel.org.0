Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17940259D3C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 19:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbgIARbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 13:31:18 -0400
Received: from mail-40137.protonmail.ch ([185.70.40.137]:26658 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIARbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 13:31:17 -0400
Date:   Tue, 01 Sep 2020 17:31:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598981475;
        bh=cjkKAThi0rU/Ekdr0wIEF3dzvNugtaKvObsQB3gEqYs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Jzki/rVBVbAhIa7Tkj1Qw2byvrMLWKfB57W1OA7CgbFbtwCG4d66emXV3AOK/lvII
         aYtJlmPrBmevRzxWjVHqSMGYcPsp31B/C6boOYShw0e1mfLF89DGFxppJjI5Fz+V15
         wQ/4BMXps+yECguSbBRvqETJCSArxdMzVF0e1Lsg=
To:     Chris Murphy <lists@colorremedies.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <FNHuKE6SxKXKEVcOcQsBsj4Beunsv7CSnCpW8TGTrI_SzKH91Xlj_DnzUIWvfYvm1Wvrf-50fdnKMSNytNVdaUjada39LSjnYXETE8oiZTs=@protonmail.com>
In-Reply-To: <JOmCIgo1pxy4fmswJRB8Y5jH6okgELkDeBUKOcoaxsFv5uSIEyJnw2M03lY3mLNYfFVKpZJTB76nmFwHcuuSm8bHUWtHFNtDg-8M84ZD6Lc=@protonmail.com>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com> <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com> <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com> <CAJCQCtR4y180_96BGu08ePGLxo8dq7mAV7H248d8X85FcS0MOw@mail.gmail.com> <CAJCQCtStgn4WjisTf6628UEcB8_eP0_9WETDSB6YtGa4VDPgPw@mail.gmail.com> <KzGwc4OhDq6qR43tQSjynifhYV7E1mfeZeQjBWWRNwithi65kenn7yS22w-bbi_OHYXAkYA6y44iMYCYLAWu2g2V3s47Uor_aYMRk-NgoOU=@protonmail.com> <CAJCQCtSB3QrA74tAH=_Fa-f8WWXJUANgt1_0PRbLcDUgBho-GQ@mail.gmail.com> <OpaR4q6qHHmnUMeRS6_aPu4cgwiwIXFIuVFcCyTJ5tR96gqj0wjAJDnspXY0SydaKgAD79u8CxC_8-XiSRkL7kkDf-Oqmz5-awgn4g4-eqw=@protonmail.com> <CAJCQCtRzKvPr=wipKcg_s4mgPjHB-W10sEJM8F_cC_GgFmA=ng@mail.gmail.com> <JOmCIgo1pxy4fmswJRB8Y5jH6okgELkDeBUKOcoaxsFv5uSIEyJnw2M03lY3mLNYfFVKpZJTB76nmFwHcuuSm8bHUWtHFNtDg-8M84ZD6Lc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I wonder how can "1192747888640" be a byte number if it's more than 1TiB, a=
nd I have only 476GiB partition. Is the 4096 multiplier surely correct for =
my filesystem?

