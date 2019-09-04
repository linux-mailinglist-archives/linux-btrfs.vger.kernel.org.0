Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6588A8DF5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfIDRzN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 13:55:13 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44428 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbfIDRzN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 13:55:13 -0400
Received: by mail-wr1-f43.google.com with SMTP id 30so11271463wrk.11
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZiJ0HUR6lJdcDYowIZo6HZJzmTJestZo83ESCndC2Zo=;
        b=fz8CyVGBD88SMCrLkd6EoOmoYLx7VlszWTjW33xtGjGaejiSzh5iZIjZOd5iQ3EZFu
         XfYRI5aEqG0tXgDIzK7OwJFrKKcWONcEpO+fy8eWJ1+cWj2eSSSDl/wm+9zl0hWYeyqD
         YI+z5pBME58Ev7cUorExXVd8hPFWikLR0EOiPTcqmNzCRjoND0uPZl/rOR0wL8Z5SLFG
         LDBqN98h8DnWYq1kpdw6SCbMJmk8AJQo836oPb/DpFJlZa7i1+nfN2U2fhQi5SQP2tb8
         nYH04hH6h0vG0OONU9BtrEch5+8XRNf2alxroLCnl8qInhmM4HrZzCjVrOzwO82tya/+
         szoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZiJ0HUR6lJdcDYowIZo6HZJzmTJestZo83ESCndC2Zo=;
        b=GW861AY3h04BWzQNERpg5YrKYvahzkgxgeqFZWt4KzDSXsAib28O8lGTuEcScAmeIn
         kLUEf9csOJIquhLYycWqHSY20yPgwvxT2oXehvt1b/jKU4NR+r2ZgGHTMhNAtgg8q6kW
         snaG0N1/OxgtmvEkz5r0JdG7/sZUZ2cD1K4Zf2dpl47yr+89Vsu4VyVxTaxOqjvs7Hzs
         JDI93fqcfPxsHOWgn09AuMHq3M66G5JMIPhAFea0VFCGI4nA+2A2EjMgOog8ek5VX+uz
         ZmwEa1X9j7DnUUeVoKgIBr+Y/bUxBWygzUlpALl0RlHlyZxfAxqpB8r9xl1alP7d1RxQ
         U4bg==
X-Gm-Message-State: APjAAAWLoHcrF2Q/pUojDq1Jw0L/Nb9TC6/voGUNzLB4QIDGjKjr1JVi
        7OsJueTAdUFgXv2SAFRLqxFIl/W1XgQ7KEvDJdugtsObYqw=
X-Google-Smtp-Source: APXvYqx6aDl4pgYMfYVa8NNemghsKlJCQHmiwZQ5Es2rmkgsALSPl8++c8ylSJLT2hViRUXX3ybJqwhja29ILTuPKjc=
X-Received: by 2002:a05:6000:1082:: with SMTP id y2mr39275485wrw.77.1567619710974;
 Wed, 04 Sep 2019 10:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
In-Reply-To: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Sep 2019 11:55:00 -0600
Message-ID: <CAJCQCtRCmG05mnTMtxYrnnY5T-gcjiVHP_dYNHSz7NuRrNpLTw@mail.gmail.com>
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 4, 2019 at 12:16 AM Sw=C3=A2mi Petaramesh <swami@petaramesh.org=
> wrote:
>
> Hi list,
>
> Is there an advised way to completely =E2=80=9Cclone=E2=80=9D a complete =
BTRFS
> filesystem, I mean to get an exact copy of a BTRFS filesystem including
> subvolumes (even readonly snapshots) and complete file attributes
> including extended attributes, ACLs and so, to another storage pool,
> possibly defined with a different RAID geometry or compression ?

The bottom line answer is no. There are only compromises.

Btrfs seed sprout will do what you want, except you can't change
geometry or compression. Last time I tested multiple devices as either
a source or destination, I ran into problems - but it's possible some
of this has been fixed, which is a question for Anand Jain.

Btrfs send receive can use a destination with different geometry,
compression, and multiple devices - but it doesn't handle relinks /
shared extents between otherwise unrelated subvolumes, although I
think that's what the -c flag is used for. I've never used it. There
also isn't a built-in way to recursively and intelligently send all
subvolumes, taking advantage of incremental send.

But in both cases, all file metadata is preserved. It's not really an
exact copy. The extent layout will be different, the subvolume UUIDs
will change in the 2nd case, and the volume UUID will change in both
cases. Etc. So not exact. But in terms of user visible aspects, yes it
would be exact with either method.

>
> The question boils down to getting an exact backup replica of a given
> BTRFS filesystem that could be restored to something logically
> absolutely identical.

Using words like "exact" and "absolutely identical" you've reduced it
down to a block copy. Only a sector copy does that. So I think you
need a better term that qualifies what you want or what your use case
really is. And also, changing compression, number of devices and
profiles, that's not exact either, and it definitely does not qualify
as identical let alone absolutely identical.


> The usual backup tools have no clue about share extents, snapshots and
> the like, and using btrfs send/receive for individual subvols is a real
> pain in a BTRFS filesystem that may contain hundreds of snapshots of
> different BTRFS subvols plus deduplication etc.

If you only ever deduplicate within a subvolume, and you aren't
deduplicating between subvolumes, then send/receive will do what you
want. Otherwise I think it's clone option. Maybe.

> So on a practical standpoint, how can one backup and restore a full
> BTRFS structure ?

Seed sprout comes the closest. But Btrfs does allow the user too
create a volume that will exceed the present feature set of seed
sprout. Therefore it's possible to create a Btrfs volume that cannot
really be replicated other than a block copy, if your goal is
exactness.


--=20
Chris Murphy
