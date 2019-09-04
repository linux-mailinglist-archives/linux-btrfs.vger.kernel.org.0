Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC86A941C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfIDUv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 16:51:29 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53089 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDUv2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 16:51:28 -0400
Received: by mail-wm1-f48.google.com with SMTP id t17so250832wmi.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pYpT3yT8vfCn3nyEPM064mr6d5BV9brsapeayDrZ1N0=;
        b=mnzvqXeyp3S49Az7ePiXVjwGhDbD67qgQepVa3k6VlcF0zN4vc/5WbMxSmnOOqpD3I
         6c7m96cZBFkBr1mvOWLoZHElD9dExhvwZJ61nQiPrc4U+gMCTBAu3L6P+1emTDLizOLX
         KXcd8e+/W0b6nf4o1WJnda3qwTPm9KwI6Y84b6iweTHwSWBuGsw/WFt2fTlRT4w1Ncek
         eBr0Nri8VUHtRTjytJOfE5bnIi9kf3Idycd4PEvADCAxlT45Dhvxw9PHvRPPfRPD1qDM
         W/y3N6NVVYJMXHZARMbILjca6TTDJSMQDG5q/dS8RevsugzYh/mvVsMjTmdCVy6Ut/fr
         1O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pYpT3yT8vfCn3nyEPM064mr6d5BV9brsapeayDrZ1N0=;
        b=i0IjrEtaqq3rXbYaWmfeKDYDEgpMqmkyqEa9yfdAgLKa80rohYcxN06Tgkb/p78sMU
         e3Zvmr3JH10X6ZkgCTBe/kal3r2LEeAm6cMR9PePDz/5b8J5ZINSH2v9S6BGK7qZvt0E
         BGorhb/6Pqq367u2hbVIg/lVFwJQ3PZFjwgfMUApX0/kj9rZAq2hgCRthIEs4U+epTLo
         mbvldUxjkHNUMhAI+VCyYGWSbN5d8tgrH7wn09ypCre/xCFgy+i3lSbBXOCtt0NotTFO
         MyH1xSG+KKrh0pW/NPG6t/2BJaQHmwzvCuCdAwjKsZo2or17rw7Ad6ht0/tjzOXRH2Nv
         qjwg==
X-Gm-Message-State: APjAAAXL1llEnnxf9X1DeMPk2oyyl/1BicsFxZCfxubyf4NUVxfvMvef
        NvgylFKEMEmoAwC4hDIt6GXftcxVWwJMzKehbOaqVeK2A2M=
X-Google-Smtp-Source: APXvYqwdhc/aaL6MEsLubIc8CD7OouWcdj4PL7ofcQeJYlfHbls7Fhxnh9e2/sg8N0uG3Au558Pe5ha4K71XkFJs1zo=
X-Received: by 2002:a1c:4102:: with SMTP id o2mr162433wma.66.1567630286619;
 Wed, 04 Sep 2019 13:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org> <CAJCQCtRCmG05mnTMtxYrnnY5T-gcjiVHP_dYNHSz7NuRrNpLTw@mail.gmail.com>
In-Reply-To: <CAJCQCtRCmG05mnTMtxYrnnY5T-gcjiVHP_dYNHSz7NuRrNpLTw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Sep 2019 14:51:15 -0600
Message-ID: <CAJCQCtT++5KNGH_RmaMzB2x50Pucg=DSbsJb_wOFp98mB0iSvg@mail.gmail.com>
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 4, 2019 at 11:55 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> Btrfs send receive can use a destination with different geometry,
> compression, and multiple devices - but it doesn't handle relinks /
> shared extents between otherwise unrelated subvolumes, although I
> think that's what the -c flag is used for. I've never used it. There
> also isn't a built-in way to recursively and intelligently send all
> subvolumes, taking advantage of incremental send.

^ reflinks

-- 
Chris Murphy
