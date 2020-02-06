Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B73B153D64
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 04:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBFDMK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 22:12:10 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:47021 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBFDMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 22:12:10 -0500
Received: by mail-ot1-f41.google.com with SMTP id g64so4110624otb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2020 19:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Buc2Oez5dHlJx43+K/aYLyMB7LIGNPAz80eJWw1DJnM=;
        b=fKxk/GufgKjO/0rkrBUfHuZW1GvYaOHLnBTMq3W7vHQslgFBQn4rsx6DIlhDzQdj39
         YCF9tAEa0Fqkq/eh0SSSmsVRjgrLpKTKxdsruxFsDwDYGoXu6/lqSnq3p0yLLsPaDAGq
         D4lHqkcCfMgx6dHKjCbOtnnFrlMisNyRPkze7LYZUkvjt9nX1sRgb7EaMR0YjSq/bjm0
         /5BgaBSoJfSfqWBgKrxrCFZ0AquZfoH2BDgEHBlea4v5pk9LJZY4UB4z9gr04aEW9Blj
         xOxlyzdmKU/+zQhmyIdLqKM8KryBJT6AOJPyu7oT8ZYJS3e9iqAsWLo8jymuN0sgCC20
         gY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Buc2Oez5dHlJx43+K/aYLyMB7LIGNPAz80eJWw1DJnM=;
        b=XJ4v7mlX6NKVUsQa6kh9OGLeHMp/RvpdPqXhtxaoHhLxO+5yDE778VSqVAHnf9e3Ye
         56XqyF0aS55ACAvzBLwionncoA7Zn4+NkacVhn+iTuGIFcqSt3iyZ5Wmd5jRVkERmiI0
         HlCwjYAdewThz6K3IfSy9zyKS+AR7bG/9vuldAB8uIwGX38K5ygOytFl9OLyUsH4HvLi
         B3PO0j3wDa96KK7PRRcXWLBOBGppBAeQNw1G8ZMlKU8eManWuyRjhKc0W3XK/zxuIcmh
         oxZD/MVjKOXAY7nAfpdQplR3UaVJDtyFRRAplV33KnAEEDgVNXlQAvVdc+QAdgTobTrY
         vXyQ==
X-Gm-Message-State: APjAAAXjBBfW42yBVlqqQMOAMRbZui7u8AWAUE3ZHSbv0vzm+K8vCREy
        S3t3WlW4Ssrpfjal4avlUOWJmw+fhaTRBubXwV8=
X-Google-Smtp-Source: APXvYqzYn88mYragIb62t7e8wYt1oyIuu+hE8MN1XVPZdWjfGV3rkMxehr2titDTcevk7Bc7RrErOyYwH9bihLmTVjw=
X-Received: by 2002:a9d:5e82:: with SMTP id f2mr17480706otl.240.1580958729599;
 Wed, 05 Feb 2020 19:12:09 -0800 (PST)
MIME-Version: 1.0
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com> <CAEOGEKE6m=n1JTfFqBy33D9n1WFTjuuyQ_q+X=jF7+tNCYsLfg@mail.gmail.com>
 <CAJCQCtRWvdhowyu9s-nA40bdEdUYGGh8P07B9QqFdGySDGAOdQ@mail.gmail.com>
In-Reply-To: <CAJCQCtRWvdhowyu9s-nA40bdEdUYGGh8P07B9QqFdGySDGAOdQ@mail.gmail.com>
From:   Chiung-Ming Huang <photon3108@gmail.com>
Date:   Thu, 6 Feb 2020 11:11:58 +0800
Message-ID: <CAEOGEKEaXzGoL2bSn=sbj0Mn8nGTySdE_+DDVHP4AP_MSUXfEg@mail.gmail.com>
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy <lists@colorremedies.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=886=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:38=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, Feb 5, 2020 at 8:29 AM Chiung-Ming Huang <photon3108@gmail.com> w=
rote:
> >
> > server ~$ mount -o subvol=3D@defaults,degraded,nossd,subvol /dev/bcache=
4
>
> Is this file system always mounted with the degraded mount option?
> It's in /etc/fstab?

Yes, because my btrfs raid1 includes root directory, '/'. I assume it
could make boot
successfully even if raid1 lost some disks.

Is it a bad idea? Or does it has any performance issue?

>
> --
> Chris Murphy


Regards,
Chiung-Ming Huang
