Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1796E140560
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 09:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgAQIWn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 03:22:43 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:35068 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgAQIWn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 03:22:43 -0500
Received: by mail-lf1-f42.google.com with SMTP id 15so17691192lfr.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 00:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OFbAbGVE9nM9oqipd7tN7ZAt3RUE4nuD1ClRK7Fj3UA=;
        b=KxH/sXYLzkDs2ZS334jT2uxNjSksHIqdxbbjtuBUvURqHxzU0IJCrHEUA4YrvO4fat
         26tu/hbsErGf1089bsjreUkWqU5uBYpxn7OimNtCzrVNJO58yPF6O2GhBgLyosqeU7BD
         yx3S2+EwyQx6VSxFPdjPBGnuZEsmx9VqZfes18t3LCuKizn+6HV2etq4raJV9dlLnK6j
         c6q1UJyC71k6xbJi3lK7Acw3d/MB8O7iWytmvoFgOl7h4XKlx0Qkwo70Ymk+kwyH0aMY
         Cc1bVza6umgK8KDivEtDZoypcWvfCxMfIHKftoXMpAVhs/RJKaLEngS9uC3CtE1Xd6hD
         S7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OFbAbGVE9nM9oqipd7tN7ZAt3RUE4nuD1ClRK7Fj3UA=;
        b=JbxMWs2tKODfM4tmiOt1fC3ousgdvv+qXH2z8mD3qSuPiubumy3qNkN4rr8w/Y2WOO
         dqpz6PdqdI69FMRaaLrLxJlz3HNXH1JAwf5W81LGKAYs3/zHJ5y2VgNLTv70teBpDAnU
         9vGOOzYzFRibF+87aqcWZs2QqE9q6ffIs9Lr4JIqhMAyF/X8tVjr9kpEevj7r7bFpHgn
         ZEkBDNElPYBxYIdNw/znpXVAdYYmsHverCgqZmkIxCx/lplp/RjturngO2XK+arb8rcg
         SmEMvpNjc6h67Cbyp4zlEhRfH+yHhmn2qRSvVFNd6+gBTnBnXaXejoG7PgVumivH3J6U
         WNPQ==
X-Gm-Message-State: APjAAAXzMmeMrc1xQNI0vEbfkf0W+dkcRdyuz3Q7qiib/sdWKaL2/8xc
        EKYDz3DQn+t4wLBh3obt50P9MFET11nUVvpz/RqZ1Et+l9s=
X-Google-Smtp-Source: APXvYqyXkjiDeyJDr1yp3ljrg/ft6XxJmy8/Wokax6vYfxryI+KTfICQ2ZTJLL3nXxYkzK1ntw6d3NZw8zwVyWFOKNM=
X-Received: by 2002:a19:710a:: with SMTP id m10mr4752898lfc.58.1579249361487;
 Fri, 17 Jan 2020 00:22:41 -0800 (PST)
MIME-Version: 1.0
References: <CA+ZCqs6w2Nucbght9cax9+SQ1bHitdgDtLKPA973ES8PXh1EqQ@mail.gmail.com>
 <6ba43f60-22d1-52da-0e9a-8561b9560481@suse.com> <CA+ZCqs5=N5Hdf3NxZAmPCnA8wbcJPrcH8zM-fRbt-w8tL+TjUQ@mail.gmail.com>
 <53da4b02-6532-5bb9-391c-720947bac7f1@suse.com> <CA+ZCqs4pTKePM4NaStAs=CWYBZbA_btqip1WiU8DC6DL13Eh_Q@mail.gmail.com>
 <CA+ZCqs5hLS3ekUpU8TTJq6UP9rjPYZjBwVYcC4xJcaMXuvSudQ@mail.gmail.com> <237d7698-63e1-cb2b-dfbf-ddf5119bd18b@suse.com>
In-Reply-To: <237d7698-63e1-cb2b-dfbf-ddf5119bd18b@suse.com>
From:   Peter Luladjiev <luladjiev@gmail.com>
Date:   Fri, 17 Jan 2020 10:22:30 +0200
Message-ID: <CA+ZCqs7u5XxyaKS=5jPTTDW9+LKdhSBip1+xRNG2VhkEtxDnfw@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs v5.4

On Fri, 17 Jan 2020 at 10:14, Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 17.01.20 =D0=B3. 9:54 =D1=87., Peter Luladjiev wrote:
> > Should I run with repair flag?
> >
>
>
> Which version of progs do you have ? Because it seems original mode
> (Default) finds the corrupted backref but lowmem doesn't ?
>
>
>
