Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F13921D69
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfEQSg2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 14:36:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54575 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfEQSg2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 14:36:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so7818934wml.4
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqhCOYAJFTpmams7XxX3MWPgOzfJIDgvstzW68NtoEA=;
        b=U+ugvLU3G8O6xGtsn5JS4FWi7hlUgAuZn6MWGJWvufmD6ol1n3M2B+0waQVxrxI+OF
         pcV5493lKOoxoc5QQdJLU+UW12SJwmXTF9F19tZrMBWqm5YqVS2Lg2p3HjQkyp0pdQpd
         Ejccj2qfBpCU1UndsJ0E46wwc6sBoVaeUW99LDarVqwZ1pf5ngIO5dZ7nIwSmetyHm2E
         j62RS34U+ydB4XYawgA1gZtnQdEeK+Me1hhrUsPJexwBRoHOYYhb5z4LBFqAwe82GYrK
         YwHmDMcGVzUAicKqQKXKnev/3b1WxwVFxnodrJWpajHbgqjte3WV++fkRFLsGpjxB4yq
         UBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqhCOYAJFTpmams7XxX3MWPgOzfJIDgvstzW68NtoEA=;
        b=jynNPz77u6RKn/jZ3ec17rKLfIkrqd90G4cuwPtkopsDzbRmkJvoLijvEqufITpYcf
         hACttVvWM9SScixjxr6EIcYzFBKOz1C8IUDGKOvz5rHTKdsv3TuXSRXAbu3Pi9yKE/J6
         QHfk3cvovuj19RcjcLLZUlOTx3HwsQAG9MvB5d68MMbHLTxA8fiEro9PZvbhfNtSBNl9
         pdJ7Wh4Y7HxPZ0hXhHGkI6mf6bVq9PULoXnf/ObDeb9Ql427e4hARps02tfHnk8AyeKk
         +ByHGVAEH3+XyCnQRyB+JF1Jt705ZOVFXnx+Vb4QGjZwU9hmpZAO8zd1DyUUIctoEPi7
         V+8A==
X-Gm-Message-State: APjAAAUB/d4Ny32qntY3xU6f+vxEDybHXgGTMi/mhSJvG3LtAMbe5MI/
        8NlkOZVrYu2PteZlPcjd4ONcwJkUeMk=
X-Google-Smtp-Source: APXvYqzybQmCi4bjvI02PQRV/yoDKnSMT8CFEXACsai/dJfjR//W8SO3BfmbMRO5qJs8hmwz7kUrVQ==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr18680411wmg.42.1558118187141;
        Fri, 17 May 2019 11:36:27 -0700 (PDT)
Received: from archlinux.localnet (14.red-83-34-150.dynamicip.rima-tde.net. [83.34.150.14])
        by smtp.gmail.com with ESMTPSA id f11sm6948020wrv.93.2019.05.17.11.36.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 11:36:26 -0700 (PDT)
From:   Diego Calleja <diegocg@gmail.com>
To:     dsterba@suse.cz
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
Date:   Fri, 17 May 2019 20:36:23 +0200
Message-ID: <2947276.sp5yYTaRCK@archlinux>
In-Reply-To: <20190515172720.GX3138@twin.jikos.cz>
References: <20190510111547.15310-1-jthumshirn@suse.de> <20190515172720.GX3138@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

El mi=E9rcoles, 15 de mayo de 2019 19:27:21 (CEST) David Sterba escribi=F3:
> Once the code is ready for more checksum algos, we'll pick candidates
> and my idea is to select 1 fast (not necessarily strong, but better
> than crc32c) and 1 strong (but slow, and sha256 is the candidate at the
> moment)

Modern CPUs have SHA256 instructions, it is actually that slow? (not sure h=
ow=20
fast these instructions are)

If btrfs needs an algorithm with good performance/security ratio, I would=20
suggest considering BLAKE2 [1]. It is based in the BLAKE algorithm that mad=
e=20
to the final round in the SHA3 competition, it is considered pretty secure=
=20
(above SHA2 at least), and it was designed to take advantage of modern CPU=
=20
features and be as fast as possible - it even beats SHA1 in that regard. It=
 is=20
not currently in the kernel but Wireguard uses it and will add an=20
implementation when it's merged (but Wireguard doesn't use the crypto layer=
=20
for some reason...)


