Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C518269C7CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 10:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjBTJin (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 04:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjBTJim (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 04:38:42 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFA2A5D0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 01:38:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id da10so3339742edb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 01:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVEz3BUdi8JXeVuBn9x/iOQUyaTlmnw3RD7a7ckWI4U=;
        b=BZXtr2kXah+s7naCjzlwVf/wy5t74cyENxw8SwsKaJwWN1/uNBEfw96aXI3U8gJpEv
         GJLYFkX/xe2c7HQP5kQXZzg4MBzwfVtUAodkSF1wyWlrU4JOTewCHTs3SYCyOBVK8afz
         Oad20PY9qT8rwzRgrjDIPIumCTQRXbEvL8g+R2X1atKlazyq9QPvG3YVB78asTUA+IWE
         eas0fKWm3qjKdfZB5FDxAuckSkk4dAQaB00yQfa+wPXTMB11VefbwYFlBdpS+wpZcDnY
         YQTRZ5a0J+PqQ5RQwnrbuT8KGK1GQ4loIoEmfEsRtycyyMtqUYdYMk2G/Qxxa5MizYo2
         T2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVEz3BUdi8JXeVuBn9x/iOQUyaTlmnw3RD7a7ckWI4U=;
        b=l7gpRzQXV3If+z0UGKPdlcAtdx8PJtroIh9mzp/oJPn8Zy3uruyeZjQmrOORjDG9hY
         XHp42t4K5NlnWOgklxXZ5aIm9M/ApA9PomwKYqNfZg4IlwkZbTmm5ixV2Y9Iac/BxNzK
         xn7Ix0pz1Gt5wrOjjdLBjJmCok7trloaWOWVD5YsCGI3/dTjjv56zon9jw5VyZfiqF+J
         Yj4bqsdsJBVM5iQ7KNldxfiwZAn6FSt53H6GaetLfbGTQCyJgTJaOggD2PgQldKBqcGI
         f3w3xayL9pdsGWhA4DX9hCNRp0Cr0MQME9PHCBKtWYi/HHmXlHCLXjpgGhI9FiJ0WFLd
         OH1Q==
X-Gm-Message-State: AO0yUKW0BOr3p8co+3QdryxFGJH2OOI2xN5bXuwYDIGIlyMddowKXjFe
        6ZymrOSdowJ40nYu9AP+dwKtZFnRi36p99phZWhG5hUh
X-Google-Smtp-Source: AK7set9bq7inb9EFMJgjJCdtp9hIbL02WEgxYw4MaZ2c7T/mMj6sDth3ZEsWg4qWztftXcl+0kmG7on6VBt9ZoTNSeA=
X-Received: by 2002:a17:906:b16:b0:8af:7efc:84af with SMTP id
 u22-20020a1709060b1600b008af7efc84afmr3986338ejg.11.1676885912253; Mon, 20
 Feb 2023 01:38:32 -0800 (PST)
MIME-Version: 1.0
References: <87wn4fiec8.fsf@physik.rwth-aachen.de> <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
 <87a61bi4pj.fsf@physik.rwth-aachen.de> <8531c30e-885b-1d8d-314b-5167ed0874ac@libero.it>
 <87k00dmq83.fsf@physik.rwth-aachen.de> <c27655bc-8582-07e2-236d-e3afc6860d13@dirtcellar.net>
 <87cz64n8zx.fsf@physik.rwth-aachen.de>
In-Reply-To: <87cz64n8zx.fsf@physik.rwth-aachen.de>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Mon, 20 Feb 2023 10:38:20 +0100
Message-ID: <CAA7pwKMvrzibHGGnFrHwF5A+euzc=_TXL8CCdW43D24FsS4uQA@mail.gmail.com>
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive operation?
To:     linux-btrfs@vger.kernel.org
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

Replace the disk offline, mount degraded, use btrfs replace with the
devid of the missing disk.
