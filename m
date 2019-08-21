Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8014297EB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfHUPav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 11:30:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40251 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfHUPav (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:30:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so2126464lff.7
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzS/sTCFIBOffAhWtxsbW0Kox2ekBYZ/CF3L0ui4cm4=;
        b=uMRvna4A+WOnMXXMqrZy0SKEKWIDGVNFeDh7OhDocb5iVEdxPNCHrkoGmNS2VqrqIu
         dEEG5nTKY+RqgnH+9mWjv+4+4dz/dINRQStCONbP2+wneWw6X3rIyg0h5F3aaO+scGTU
         Fd+0N+VGDA2mg1Y+pqkQlhUzbUnLTKbVTl3zpu+NuUURsWHo+VjGwGaUGuNg0kRfBLx9
         evGKVE98ys1DsK+G0KDiMIpFbWuIN8b8WJr1snfHxNQpRlP3jvd140T29cgBgPOUs9Dr
         5GtlTsLD1xnTTsF131DqZyMPPVw3uuczOkc27qph7wIK0YK5tJl22iOR0L3qQGN+kW9n
         +zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzS/sTCFIBOffAhWtxsbW0Kox2ekBYZ/CF3L0ui4cm4=;
        b=YVhgzAEdlyCsCqO7T3ni8mTYhuW0mtyWn51viehzv2wgiwlAb4Nuvu7RjqxjY88Nhk
         o45V00dwnKlaQiqaATH9g4OQk28p7m8DwsLo8+JUnW3zN/EWgNjBpIJZ9FkZQfJ7if7k
         0Vq2bYyVp8rzg8LTDpuQia24WpZLeunu4W/EERTJcxDMf7P8ahkVZB/g8NYbNNbtDv2N
         0b4gS8Kligy5ONEuwosmYQ2D6RKN9mFattutNR3l1vlnxCyoPyLjyu8gjpGPkSWz/3Z+
         JVvV5Dc5FYgLcT9PDzZlloUlAh3HUAzFstsiDyb4zEkfeOTehxRaEuRIXKgCGTkHHBZP
         VVdg==
X-Gm-Message-State: APjAAAX/tfA0YlnlPzXrA4wCC4vd56gk/s1WzC6qArFNoJZgW3J8pacQ
        /rf6sKQyPg+rl4VNWiTu2NtG95eIhgFGeO7iGwOhakgV
X-Google-Smtp-Source: APXvYqykfSVlPyGMsntZsdbM2/H6oJ3p1pwbEfQ+8s6cAjlZrEErRq5mJ47oJUpLpSlrlYoqmEyJ8xUF4soQjrQfjEg=
X-Received: by 2002:ac2:44af:: with SMTP id c15mr20600824lfm.32.1566401449129;
 Wed, 21 Aug 2019 08:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190816152019.1962-1-josef@toxicpanda.com> <20190816152019.1962-5-josef@toxicpanda.com>
In-Reply-To: <20190816152019.1962-5-josef@toxicpanda.com>
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Date:   Wed, 21 Aug 2019 15:30:32 +0000
Message-ID: <CAHhfkvzbWc=-bq+GpsSpXLT9fM83Aypwmsoyo07Svt643JcfTg@mail.gmail.com>
Subject: Re: [PATCH 4/5] btrfs: do not account global reserve in can_overcommit
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

On Fri, 16 Aug 2019 at 15:21, Josef Bacik <josef@toxicpanda.com> wrote:
> Fix the can_overcommit code to simply see if our current usage + what we
> want is less than our current free space plus whatever slack space we
> have in the disk is.  This solves the problem we were seeing in
> production and keeps us from flushing as aggressively as we approach our
> actual metadata size usage.

FYI - I'm not sure if it was the intended effect of this patch, but it
fixes the problem I was seeing where deleting a device or rebalancing
a filesystem with a lot of snapshots and extents would fail with
-ENOSPC. With this patch, the operation succeeds - although, the
operation seems to require more RAM than merely upping the global
reserve size (which also allowed the operation to succeed).

Hope this helps. Thanks!
