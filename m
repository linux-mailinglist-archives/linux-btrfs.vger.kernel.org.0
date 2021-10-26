Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC243B3B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 16:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhJZOPY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 10:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhJZOPU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 10:15:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C6FC061745
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 07:12:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t7so14254539pgl.9
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaqPxK5urZzaDZZ06axYOLFB5bDlAqXPfvGwb4Tn9Y4=;
        b=EG5fkpsEoLmwfFNoNrhzimJfW5ofdsTwQtcC81LkWHBPqulkALyD2JOQCUpWgOK2O6
         5tznx46Pghkq0/K+lxVw01mihroe8lH0XeqDxBQW4I2eyeBaEA+T40ampjZVOcLG8pMl
         HIwDJpWnXH/Nl89Z382S5HJhp4NSv1uGhhkELnIrUSTmRM/aNX3ERLvSVk9bvWXBZv/U
         HtoO9TEwLb+bA8GGI2ju5YW17w0JYdZlL8Mcm71sCuOppagEI/lI5iHsk4vXMdBpeyQP
         jP0eyPJJj0sSpyh1/yR7AclR02bTQ4xQzk/4V8cJxoBPRaaqAydhrYAbOwo7/bkPOxvV
         pHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaqPxK5urZzaDZZ06axYOLFB5bDlAqXPfvGwb4Tn9Y4=;
        b=NgsCRxDWIBWeMttc3MGh7wfXT/l1EtZjGt7MO+pjxDLxZwULRLoqg2eMP+z5DMGXxo
         cB0cuB1yu4qPLQE9T712dGpa/+SrgkpvjhJ6DGMkHxGx//vLSLeJo3KsLdYg9yNK977X
         zt7M5z1leSfKFUiJKimzanHJtpjQpZ+p5Puhn0JXzG0iQTGLZl9nm77r1HXfejXU3Cc5
         ljxo+67evj5iWpXnx9rJ+sJnWqS1zd4XEqVYOw6CGiVYB5t3kKbCHy5BxJJjGFxzr7rO
         j5eZ/Vo2zFE7uFDJyDvWMK13KVizuYk30SG/OW7c3kFZHsYacsCwPrDTDnUyb9+K8ghf
         4d2A==
X-Gm-Message-State: AOAM532TEqiP0kfh6NbyI7abxs8vICH5jlf+u+ZqOYozcIHAgC+0ShRT
        uADa/uO0Khtg0zvThNbFLmGQS11CGHK8QWp8Pjg0H0xy6vk=
X-Google-Smtp-Source: ABdhPJzHtBaaaow34Kr6vGdWoYQor2PWvamtZ7pZkPCx7wnv+PLBCXKgqpH0UvnfmVYqWbxRwCmUcw1ni0e0dw7hVz8=
X-Received: by 2002:a65:4d4b:: with SMTP id j11mr19080212pgt.27.1635257576213;
 Tue, 26 Oct 2021 07:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de> <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de> <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com> <884d76d1-5836-9a91-a39b-41c37441e020@rx2.rx-server.de>
 <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de> <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
 <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
In-Reply-To: <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Tue, 26 Oct 2021 16:12:45 +0200
Message-ID: <CAA7pwKOrgt6syr5C3X1+bC14QXZEJ+8HTMZruBBPBT574zNkkQ@mail.gmail.com>
Subject: Re: filesystem corrupt - error -117
To:     Mia <9speysdx24@kr33.de>
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 26 Oct 2021 at 09:15, Mia <9speysdx24@kr33.de> wrote:
>
> Problem with updating is that this is currently still Debian 10 and a
> production environment and I don't know when it is possible to upgrade
> because of dependencies.

Maybe you can install the buster-backports kernel which currently is 5.10.70?

https://backports.debian.org/Instructions/
