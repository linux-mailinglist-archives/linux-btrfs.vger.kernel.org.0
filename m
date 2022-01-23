Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F834974EC
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jan 2022 20:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiAWTSL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jan 2022 14:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbiAWTSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jan 2022 14:18:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B1C06173B
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 11:18:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r22so2108422wra.8
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 11:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hc3XLZziHeh8TMlJQ7zzS0cVsW8fKzPwYZT9xd9wx4=;
        b=eEYgcWE2fVMnn9QqX5re5usWDDootfRmYrWTBPwhoSW6ktiMIwcHSuiZoqsaiE+A9O
         whBy9TbVKGrfd+n32YiO9mOvUyb3Ygn9wMOrWxEm/jHnIMur9qtB8zjCfNC9vg8nnmY4
         Ddo6Mu1g7g82EY2mMcly/Sk8IieETqj8m7aVuHZZ0Q8c6TuB2ORF+cMtun4w5YnuZGtE
         h4k1+Oo8LqzbQm5zMhaYX+TzPNlMlSjQgrOeHOSTpKzsCmpzzPAvU0hgxgBQCvhd2iK9
         S72vmG+CPNCQbf/ztHFmnmPuV7jZjyNFVbiSIk9vVvzFNCnIShUrvng6nDJ+rlUXctbK
         2qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hc3XLZziHeh8TMlJQ7zzS0cVsW8fKzPwYZT9xd9wx4=;
        b=upBcvawoKG+l/7Iuhqy7OP9nVfkq0AM8t3ATYvc2o2gZAESlx7pKRlJm/Y+9WK2xk5
         xkHAmx9MAzq0wLRKUnSV/mHN47Ut9T2Ece1xulNqbBfd41eq6+3G9dkoHsp3pEE0IUI3
         dZfBa6p7GqI/MNhXGn6xdjjkVaEvAK748tj7xS7PHpSiMRgiezjGtylSPTdG1w/+tun/
         yN7dHuEjByP88gcyr4WsTq+tPf94HInFLFrMHEqM3GGGrH9a+k+omfNfaorwAvVx6NOL
         9w1+Sv0OthSOJh4hgXrmR6ZK6ay9Nrz2ZYm95dN13UqFdTN7mNBHT2IzfYK87hu5Br0x
         FMDg==
X-Gm-Message-State: AOAM530qa4iWh8z1Ez5fCmfWDt+4CQCmnRZjIkvJ4ePEz1YM7634O+Fu
        EXbQ8DA11B/V539gO1QO4fOIqQlpYHMmVw==
X-Google-Smtp-Source: ABdhPJz12Gu0jw9Qzme67DVPAxBX+5zD0RliXxHSjUpSxe6DJL22h45lLD6Qre5Jy72szVo0UFG1zg==
X-Received: by 2002:a5d:42c3:: with SMTP id t3mr11939549wrr.301.1642965488772;
        Sun, 23 Jan 2022 11:18:08 -0800 (PST)
Received: from arch.localnet ([213.194.149.41])
        by smtp.gmail.com with ESMTPSA id c8sm14068462wmq.34.2022.01.23.11.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 11:18:08 -0800 (PST)
From:   Diego Calleja <diegocg@gmail.com>
To:     linux-btrfs@vger.kernel.org, Andrei Bacs <andrei.bacs@gmail.com>
Cc:     cpu808694@gmail.com, Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Kaveh Razavi <kaveh@ethz.ch>,
        "Bacs, A." <a.bacs@vu.nl>
Subject: Re: inline deduplication security issues
Date:   Sun, 23 Jan 2022 20:18:44 +0100
Message-ID: <1828959.tdWV9SEqCh@arch>
In-Reply-To: <CAKDzk=-HZardsLFH5c9HYre73NYNszUJqpfsh0YJnnaQToB3BA@mail.gmail.com>
References: <CAKDzk=-HZardsLFH5c9HYre73NYNszUJqpfsh0YJnnaQToB3BA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

El s=E1bado, 22 de enero de 2022 19:42:47 (CET) Andrei Bacs escribi=F3:
> We have found security issues with inline deduplication in storage
> systems, using ZFS and Btrfs and running examples. See the attached
> paper for details.

(Not actually a btrfs developer here)

I am confused, Btrfs does not support inline deduplication. The inline=20
deduplication implementation used in that paper is pretty old and as far as=
 I=20
know it's not maintained (people seem to be happy with out of band=20
deduplication).

You might want to contact the developer on the inline implementation: https=
://
lore.kernel.org/linux-btrfs/20181106064122.6154-1-lufq.fnst@cn.fujitsu.com/

Also, this is a public mailing list, so there is no point in waiting until=
=20
23rd of February 2022 to make things public.

Kind regards.


