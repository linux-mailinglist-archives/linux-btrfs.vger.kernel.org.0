Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4D155260
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 07:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgBGGQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 01:16:42 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38642 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgBGGQm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 01:16:42 -0500
Received: by mail-ot1-f52.google.com with SMTP id z9so1099868oth.5
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 22:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o/VfNf/UtaEsWN57i9UtjxYqGxloDz5/jH6sJ1RkrnQ=;
        b=HEsLIy/ODnRQJwtuI9MtGRfKPVvP4nBDYWbHtlf1j56bzQlnfWicEtLXX8GsSNdGGH
         Aq+7UVa2VUFyBGauD/I2xbyXr/xtgqQdwNGMB/MVPkdLVQEUudCCasesTh4y1EBrO3Ej
         hL/jKEtICtpfUtlM1SQNZgVXRnAVe834g94u5LQCnBQMpuWs7JQt/vDKTBPvYOr7QLLA
         0BQdnoLASk80+sjwLGh4d/JAvBr12C+YDQ/7GbSdl/V8hdl7JIpceb3xaJzeQA+0TVGZ
         td/I5gXhyQZdrJN3RJZdyO3qjNgBct7xuqMKlu6aGI2GxCN+Qv2fl64lu/15QwPhYLQW
         fXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o/VfNf/UtaEsWN57i9UtjxYqGxloDz5/jH6sJ1RkrnQ=;
        b=sk7TTep4RhuLNCKwkn3JydnMlIv4S4tsctVQYJBUAZnn/Kx1J9xjBZHRigh96N7eQK
         ey0DHNzySPTKeFZySfP7ZD9w1H5DAB3ZjE3VeFVDhk6crImRozy7QAqjcnagrxeFhw6x
         I+YBtvUVNGlGAXITAboEmN8UThEHLEW4uyt4aKlFX32W49crwzPRy7VTH0RUO5m2Yhwi
         ASRXpevm5/53Az2MlMYyWdProf6o7SWY/f+Pd9niAZ0zTivWdUVkVDryYJbBxYJH/s0p
         syOYhXK1qY2LZwhFc+lAFyb4W+oyxx2svZyvS48d/9fAJ/8Pg+GXggR7G/hor+SByRy6
         7b/A==
X-Gm-Message-State: APjAAAVo6NotnBbZ8xIuWSgkR3S+6oZ1JP/5SSVEgFuu1qZUneW0sbSg
        VDvgIxqUxORMzBf/sn8YD42UGRzBA7nNvHg4JZNTP3vX
X-Google-Smtp-Source: APXvYqwPcoMLeD4EC3ctrsWczoE4bTQ2iJgWdDOWDyT1WvTcsuzGav6gvvFz9HkxAKKTw3CF5QrReDF66UfxUCJ8QaE=
X-Received: by 2002:a05:6830:1e95:: with SMTP id n21mr1521505otr.25.1581056200971;
 Thu, 06 Feb 2020 22:16:40 -0800 (PST)
MIME-Version: 1.0
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com> <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com> <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
 <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com> <CAEOGEKGsMgT5EAdU74GG=0WbzJx81oAXM0p_0rFhZ4vFmbM3Zg@mail.gmail.com>
 <efb830f0-9990-efba-aead-60cef00ab3cb@gmx.com>
In-Reply-To: <efb830f0-9990-efba-aead-60cef00ab3cb@gmx.com>
From:   Chiung-Ming Huang <photon3108@gmail.com>
Date:   Fri, 7 Feb 2020 14:16:29 +0800
Message-ID: <CAEOGEKGgA7-3CsjYhgZJdZjzHPJNQ9xZETjjZwAoNh_efeetAA@mail.gmail.com>
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> All these subvolumes had a missing root dir. That's not good either.
> I guess btrfs-restore is your last chance, or RO mount with my
> rescue=3Dskipbg patchset:
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D170715
>

Is it possible to use original disks to keep the restored data safely?
I would like
to restore the data of /dev/bcache3 to the new btrfs RAID0 at the first and=
 then
add it to the new btrfs RAID0. Does `btrfs restore` need metadata or someth=
ing
in /dev/bcache3 to restore /dev/bcache2 and /dev/bcache4?

/dev/bcache2, ID: 1
   Device size:             9.09TiB
   Device slack:              0.00B
   Data,RAID1:              3.93TiB
   Metadata,RAID1:          2.00GiB
   System,RAID1:           32.00MiB
   Unallocated:             5.16TiB

/dev/bcache3, ID: 3
   Device size:             2.73TiB
   Device slack:              0.00B
   Data,single:           378.00GiB
   Data,RAID1:            355.00GiB
   Metadata,single:         2.00GiB
   Metadata,RAID1:         11.00GiB
   Unallocated:             2.00TiB

/dev/bcache4, ID: 5
   Device size:             9.09TiB
   Device slack:              0.00B
   Data,single:             2.93TiB
   Data,RAID1:              4.15TiB
   Metadata,single:         6.00GiB
   Metadata,RAID1:         11.00GiB
   System,RAID1:           32.00MiB
   Unallocated:             2.00TiB

Regards,
Chiung-Ming Huang
