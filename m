Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915069AAB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 12:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBQLrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 06:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBQLrk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 06:47:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5BC67464
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 03:47:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ec30so3495411edb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 03:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBJ9LUZZ7KMGrlSWBFWtJbQbzBWG0QCcSN0ET+fQ01Q=;
        b=Y/CfGHovFVqWNPcPZA73OJrSsFhK/rLoAYKqogdXvDheTVfREFR4XpfMMmpHqsw5Kd
         9KRRaL8TV3/TGroFujl5kzzLGgTRiQm6W+hPmI+s5hufhUz+hQSglG0s4zPs2KhemVfd
         Y/37W5U+CamljMuI7kG3g3pxHDl+SfOOxsdcvIC7Kmnfwl9TXNsRSPzVN3mZKzhziwI4
         3DnBOqbqZ6Mg20ZZ5YseQK/Vp1vgFfQ9ntXByQFoSPbz0kCZFy2/G6VcPDIHGGNAALKq
         7DznUkoYbYEg+eJO0kthklCZxQ7cDrry1vHN2mSbu7zR4EaYCZljdjGXZY9jP6Tb2hm9
         9YVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBJ9LUZZ7KMGrlSWBFWtJbQbzBWG0QCcSN0ET+fQ01Q=;
        b=aqgElZB5MKNPYCQgVM2882uQ2uUeIdC5Ik/+oaj3NH8NkU7E8f+nlgdfT/U5qRmSgv
         Sz5mcR3FV0WVDkBZdY+iTkvKrp81ATteK51LiVjDolFuT3vzUn/OGHYjglgRXwihmUJC
         qXHtOzOUCdBN3AzryW8N/pVQzxFhchAz3hRuVbBHph90Z8nGe2a94HBhgHoNVq7aAVNS
         FH55LecbyEeg+Fuiaiq0XBGs86Q01kLe7rTDFgVaI1Ve6wavPt/kB12D6a/yXpm11F34
         uXmwbtgDKw/aIv9FCz3YlvWGGaErtb01gqUT8tUq4JkjzwOZ69YzWGgnbFjFJzI0u6Bv
         j1SQ==
X-Gm-Message-State: AO0yUKUQwf8vRdpeG4gJV8CXFI0KKP/ETsH1mCe6pPLvosVbn2AFwTaq
        q2gnX2Vbnvjndjx7M3eybeSYZSmNfqgTk8o0hd+DbkOotYHmmQ==
X-Google-Smtp-Source: AK7set8uynHZOuadHGakpvrz/C2a5DidhAbesha7CxH9cOo5Ip2kccyekXGqYeC6P6xTSnjsuAV1AzGaJTwSXn3fhAs=
X-Received: by 2002:a50:9f2f:0:b0:4ac:b626:378e with SMTP id
 b44-20020a509f2f000000b004acb626378emr549972edf.5.1676634454274; Fri, 17 Feb
 2023 03:47:34 -0800 (PST)
MIME-Version: 1.0
From:   Kang Chen <void0red@gmail.com>
Date:   Fri, 17 Feb 2023 19:47:22 +0800
Message-ID: <CANE+tVrwoRxcOqK5vJCzEJonD9Z=80mdXUqvE3RoOcrVgRhrBw@mail.gmail.com>
Subject: Return of btrfs_del_item
To:     dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I found that the return value of `btrfs_del_item` is handled
elsewhere, is it needed here?
Maybe we should save the return value to `ret` and abort the transaction later.

https://elixir.bootlin.com/linux/v6.0.1/source/fs/btrfs/delayed-inode.c#L1075
