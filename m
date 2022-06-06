Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01AC53EC43
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiFFOdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 10:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbiFFOdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 10:33:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B7F2AC5E;
        Mon,  6 Jun 2022 07:33:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q15so12086125wrc.11;
        Mon, 06 Jun 2022 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T2WMsUxzc11zSP3SEaSzeZg0r4jEfgd/2nHBgyOqTNM=;
        b=oPQMW767uSFPmkznlyNOwLkO1E+Py3pEiUAdu5aDoOx9B1P8D+xAgWXPm7Qhy7Ue1a
         XC+0+nLLS6nWuaJ7HrmOuO2j1epyaQD/sm/m0sUNfE7NMgaGWn6RCNaJx30xgy2nWtb3
         nik5QBQVlxZ8TdXo0cGSLZ2KstAI+3j4aNs/LI4RZd+TL5hAnOBSxcGNr3jPj8uhFujd
         0aTha74diX4ObZ+TFbFzxjOcDtiFBKcI22AlVc2BZH5ip07FtZIena6BZLtruAxAOnio
         Qca12p3StCU+L3hzjXUh8ORNZm3vI2TyyjfAp00x+VUF3xGUYaUfBNXZC7ZtX7kTDf2F
         gp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2WMsUxzc11zSP3SEaSzeZg0r4jEfgd/2nHBgyOqTNM=;
        b=2cQhA72DB5+7pEdbrqmXrK3kWvccF/tGNuo+8Yz0ofUwvUeUJMTleaDH5FDamTKxWa
         UBlSRMfI/Ep/bCGeqpKy9oQK2lLz49SUgqEXZ0rJeaNSixCyoPZKieGuKwqUgluJNHq+
         yrwBO7drsg0fyl0hLFhnu+wPlwSRf4faes88y7I92TvjYQTVqjOZW/mQgjfczM8zQR/g
         sL8QG0agW5irxKhT1hftRGdQKpsAPgAP6OD9pC64iP5uc1roQZj2szo8H2XSgk3DroTq
         KpkgwM9jgjARLwMH41w6R1an0baWFBtLlIZ3CsDlaN/jr+eUfSJ7wnJcEvs3UgE2I+tz
         e1lw==
X-Gm-Message-State: AOAM530UPE0gUp/aDBX4hB7t8xm5npKF3NDQKyAhETP6D091byjbpozP
        ZCTN+O7G+V1qXAXjwtGGmEDmvkXbF9M=
X-Google-Smtp-Source: ABdhPJzqN4cWZJ6Ag/jC5Ezs4cbaqkGE6PFX1fiQ+wVAcUBIwMFyV9pdT4P/LI0Z247Z2KIkNphKhQ==
X-Received: by 2002:a05:6000:18a4:b0:210:7e22:cd07 with SMTP id b4-20020a05600018a400b002107e22cd07mr21611412wri.703.1654525979972;
        Mon, 06 Jun 2022 07:32:59 -0700 (PDT)
Received: from opensuse.localnet (host-79-13-108-3.retail.telecomitalia.it. [79.13.108.3])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b0039c45fc58c4sm8177822wma.21.2022.06.06.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:32:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dsterba@suse.cz, "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Date:   Mon, 06 Jun 2022 16:32:57 +0200
Message-ID: <2242021.ElGaqSPkdT@opensuse>
In-Reply-To: <20220606103243.GZ20633@twin.jikos.cz>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com> <1793713.atdPhlSkOF@opensuse> <20220606103243.GZ20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On luned=C3=AC 6 giugno 2022 12:32:44 CEST David Sterba wrote:
>
> [snip]=20
>=20
> Yes I can pick 1 and 2. Removing the whole series is needed in case it
> crashes tests as it affects everybody.
>=20
Thanks!

If everything goes smoothly, you will receive the remaining conversions=20
within the next days. I still have to make several of them  (both from=20
kmap() as well as from kmap_local()) and the ones already done and placed=20
in my queue still need to be properly tested.

Again, thanks,

=46abio



