Return-Path: <linux-btrfs+bounces-1314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B931F8278A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 20:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6E7B213AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC60A55C11;
	Mon,  8 Jan 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJf9HAJD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DFB55C04
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7cc970f8156so459751241.2
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704742626; x=1705347426; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nomm+1RTXPEit5JvF77Twoztd95whCx4jBUaUFpCm60=;
        b=iJf9HAJDhEbtVceK2WJXbqJ7mrQsgXgabm4qoy2ajJF6kyFKZnG1JdrSJZQkR88fyM
         4YUzdpCQ3O3D75aErBElMBHgNaQHC7NcKaqXUyoH4jIeYSJnK6o8JDokH6UPeSZMT/kw
         kwKz2x4KRupESxCtUJe4FK9QglxtuqmBqtyxAUcHOik2NmoLoJVSmFVo58efKzCjcwNg
         rSKDSLo8KjLYlOsbAv1ol3Cw/oR1esSuHfPRNCAjqYmNG+KeHsPcCANHehrmfp3cR8bc
         jYTHV88K7kqTR3JXY8Lu1jMq62tIbmn0VY13YnqPAz8cxrNQBCvjUhpCFRi3f0+2IJMR
         tLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704742626; x=1705347426;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nomm+1RTXPEit5JvF77Twoztd95whCx4jBUaUFpCm60=;
        b=vL7Xd/C8DMsC0XIvP/C4VGh7d6JwNbqA0jGg7HYlD/tYinV1PRwM4euxT0shgoml/T
         PSABeM5bTvnGCu+pobJiVDCvYfaggYcIkfhguY8V4j9deIE61k/ffDpa/KhYnEnbJI8J
         /HQTYCyWJFtA3dRFF34ZcqezWFHHBzPTHdZ5q+BuOTXrbqONuSPEbMylvOGi6WM0jqr0
         Sem/9UcbK9YmurUw7X7P5dIPejDT4zVYB96J2aXS5sx+NYmFy1SdnRPHagiqbzA6qFxF
         F6z6oBsQy5wTetKp1WtGTRurYV7NGccWtVzv/QwUS2pAKyXvB0i8PIcwBJweTJjiI5q8
         n1SA==
X-Gm-Message-State: AOJu0Yz3fy3mx+Bq/HyugJ/0VQLeCzXJaI1w7JN/cfsaSgemEr5SiSKa
	1uQMrHwci2Q7efed8lXFZR3t57fE1dNSbmWeeqk=
X-Google-Smtp-Source: AGHT+IGEFYEMOuXg54pEYYq2qu1en+OqoPUYUo970ktDJ/kyTPl3DxSgdoXy/le7dXngA2Qa19btYu9j7FSYPtUGul0=
X-Received: by 2002:a05:6122:902:b0:4b6:ca2c:b420 with SMTP id
 j2-20020a056122090200b004b6ca2cb420mr1161844vka.2.1704742626032; Mon, 08 Jan
 2024 11:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
 <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com> <CAFvQSYReFG3hUJCoRps36hbR1-PaprSsEirodtSS9Bc9nThEtQ@mail.gmail.com>
 <354d852c-0283-4008-ae20-e00788b8d5eb@gmail.com>
In-Reply-To: <354d852c-0283-4008-ae20-e00788b8d5eb@gmail.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Mon, 8 Jan 2024 20:36:54 +0100
Message-ID: <CAFvQSYRHFkjDEyd7rBUnpZm4oQe0MKd3jgkR8WPuK_2KPvSDwg@mail.gmail.com>
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
To: Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrei,

> The error is correct. There is no subvolume with UUID
> 29fca96e-ca6a-3d4b-b7c9-566f1240d978 and according to the output in your
> other mail there are no received UUIDs which breaks send/receive chain.
>
> Unfortunately the output you sent was *after* your script already
> destroyed the original state of both filesystems - it recreated
> subvolumes without running successful send/receive first. So we still do
> not know the state when error happened.

I am really sorry, I didn't think of this.

I've followed your suggestions and tried to reproduce it once again.
This time I booted from extern/root-rw two times and performed
ext->int->ext in between, but didn't manually change files like in the
previous runs.
After the second boot send/receive failed as expected. I've omitted
manual mounts/unmounts this time from the command-list.


I would be really glad if you could - once again - have a look at the results:

btrfs send source_disk/root-ro | btrfs receive extern/ #initial source->ext
btrfs send extern/root-ro | btrfs receive intern/ #initial ext -> int
btrfs sub snap extern/root-ro extern/root-rw # rw snapshot to modify
ext, will be used as subvol when booting
btrfs sub snap intern/root-ro intern/root-rw # rw snapshot to modify
int, won't be used

# boot fedora from extern (+ install firefox via dnf) + shutdown again

btrfs subvolume list -pqRu intern/
ID 386 gen 576 parent 5 top level 5 parent_uuid -
              received_uuid 8d1ee193-2522-014b-b436-032f0a4fc461 uuid
a88bb4ed-65c8-db4f-b209-9ca07eaf3d21 path root-ro
ID 387 gen 576 parent 5 top level 5 parent_uuid
a88bb4ed-65c8-db4f-b209-9ca07eaf3d21 received_uuid -
                 uuid f4d1c9cc-3e4b-4248-9b02-626bed3ad238 path
root-rw

btrfs subvolume list -pqRu extern/
ID 345 gen 588 parent 5 top level 5 parent_uuid -
              received_uuid 8d1ee193-2522-014b-b436-032f0a4fc461 uuid
21cabdfd-02f5-ab4b-943a-6ebf88326dae path root-ro
ID 346 gen 611 parent 5 top level 5 parent_uuid
21cabdfd-02f5-ab4b-943a-6ebf88326dae received_uuid -
                 uuid 0c9d9843-32f3-d341-b657-a33de46c9d0e path
root-rw

sh sync_ext_to_int.sh

btrfs subvolume list -pqRu intern/
ID 388 gen 583 parent 5 top level 5 parent_uuid
a88bb4ed-65c8-db4f-b209-9ca07eaf3d21 received_uuid
b326e1fe-7295-3948-a401-b6de850e213c uuid
f055e3e8-d048-744c-abb4-c3efd87c4875 path root-ro
ID 389 gen 583 parent 5 top level 5 parent_uuid
f055e3e8-d048-744c-abb4-c3efd87c4875 received_uuid -
                 uuid da51f30f-f10a-b04c-b7a7-5e718118a49c path
root-rw

btrfs subvolume list -pqRu extern/
ID 346 gen 615 parent 5 top level 5 parent_uuid
21cabdfd-02f5-ab4b-943a-6ebf88326dae received_uuid -
                 uuid 0c9d9843-32f3-d341-b657-a33de46c9d0e path
root-rw
ID 347 gen 615 parent 5 top level 5 parent_uuid
0c9d9843-32f3-d341-b657-a33de46c9d0e received_uuid -
                 uuid b326e1fe-7295-3948-a401-b6de850e213c path
root-ro

sh sync_int_to_ext.sh (intern was not changed, just to keep ext->int,
int->ext in order)

btrfs subvolume list -pqRu intern/
ID 389 gen 588 parent 5 top level 5 parent_uuid
f055e3e8-d048-744c-abb4-c3efd87c4875 received_uuid -
                 uuid da51f30f-f10a-b04c-b7a7-5e718118a49c path
root-rw
ID 390 gen 588 parent 5 top level 5 parent_uuid
da51f30f-f10a-b04c-b7a7-5e718118a49c received_uuid -
                 uuid 8a1f263b-581d-1847-a0da-0fc17e1ca2c4 path
root-ro

btrfs subvolume list -pqRu extern/
ID 348 gen 623 parent 5 top level 5 parent_uuid
b326e1fe-7295-3948-a401-b6de850e213c received_uuid
8a1f263b-581d-1847-a0da-0fc17e1ca2c4 uuid
c481acb9-b077-7841-a4b6-a0273f7aa12f path root-ro
ID 349 gen 623 parent 5 top level 5 parent_uuid
c481acb9-b077-7841-a4b6-a0273f7aa12f received_uuid -
                 uuid cf80f17f-3d5d-7744-83f4-096b7688288c path
root-rw

# boot fedora from extern (remove google-chrome and chromium via dnf)
+ shutdown again

btrfs subvolume list -pqRu extern/
ID 348 gen 623 parent 5 top level 5 parent_uuid
b326e1fe-7295-3948-a401-b6de850e213c received_uuid
8a1f263b-581d-1847-a0da-0fc17e1ca2c4 uuid
c481acb9-b077-7841-a4b6-a0273f7aa12f path root-ro
ID 349 gen 633 parent 5 top level 5 parent_uuid
c481acb9-b077-7841-a4b6-a0273f7aa12f received_uuid -
                 uuid cf80f17f-3d5d-7744-83f4-096b7688288c path
root-rw

sh sync_ext_to_int.sh

manually executed line-by-line in expecting it would fail it failed at:
btrfs send -p extern/root-ro extern/root-ro-new | btrfs receive intern/
At subvol extern/root-ro-new
At snapshot root-ro-new
ERROR: clone: cannot find source subvol 8a1f263b-581d-1847-a0da-0fc17e1ca2c4

interestingly, despite send-receive failed/aborted with the message
above, intern/root-ro-new was created and contains contents but left
in writable state:

btrfs sub show intern/root-ro-new/
root-ro-new
        Name:                   root-ro-new
        UUID:                   d32788b9-5572-5743-bf27-46b57c8b92c1
        Parent UUID:            8a1f263b-581d-1847-a0da-0fc17e1ca2c4
        Received UUID:          -
        Creation time:          2024-01-08 20:14:59 +0100
        Subvolume ID:           391
        Generation:             596
        Gen at creation:        594
        Parent ID:              5
        Top level ID:           5
        Flags:                  -
        Send transid:           0
        Send time:              2024-01-08 20:14:59 +0100
        Receive transid:        0
        Receive time:           -
        Snapshot(s):
        Quota group:            n/a


btrfs subvolume list -pqRu intern/
ID 389 gen 588 parent 5 top level 5 parent_uuid
f055e3e8-d048-744c-abb4-c3efd87c4875 received_uuid -
                 uuid da51f30f-f10a-b04c-b7a7-5e718118a49c path
root-rw
ID 390 gen 594 parent 5 top level 5 parent_uuid
da51f30f-f10a-b04c-b7a7-5e718118a49c received_uuid -
                 uuid 8a1f263b-581d-1847-a0da-0fc17e1ca2c4 path
root-ro
ID 391 gen 595 parent 5 top level 5 parent_uuid
8a1f263b-581d-1847-a0da-0fc17e1ca2c4 received_uuid -
                 uuid d32788b9-5572-5743-bf27-46b57c8b92c1 path
root-ro-new


btrfs subvolume list -pqRu extern/
ID 348 gen 623 parent 5 top level 5 parent_uuid
b326e1fe-7295-3948-a401-b6de850e213c received_uuid
8a1f263b-581d-1847-a0da-0fc17e1ca2c4 uuid
c481acb9-b077-7841-a4b6-a0273f7aa12f path root-ro
ID 349 gen 636 parent 5 top level 5 parent_uuid
c481acb9-b077-7841-a4b6-a0273f7aa12f received_uuid -
                 uuid cf80f17f-3d5d-7744-83f4-096b7688288c path
root-rw
ID 350 gen 636 parent 5 top level 5 parent_uuid
cf80f17f-3d5d-7744-83f4-096b7688288c received_uuid -
                 uuid d73b4afe-0837-8046-b798-21102cb82d4d path
root-ro-new

Looking at the last output I have to admit I am confused.
The error mentioned missing parent with
8a1f263b-581d-1847-a0da-0fc17e1ca2c4 for intern/root-ro-new seems to
be there. Isn't this, as expected intern/root-ro with
8a1f263b-581d-1847-a0da-0fc17e1ca2c4.

Thanks for all your patience and help!

Best regards, Clemens

