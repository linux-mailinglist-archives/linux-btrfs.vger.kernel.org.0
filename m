Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7EC2079
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 14:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfI3MRl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 08:17:41 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:50579 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbfI3MRl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 08:17:41 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 08:17:40 EDT
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 69B913C0199C;
        Mon, 30 Sep 2019 15:10:51 +0300 (MSK)
Received: from iva7-f08b2a8dca2b.qloud-c.yandex.net (iva7-f08b2a8dca2b.qloud-c.yandex.net [2a02:6b8:c0c:6e00:0:640:f08b:2a8d])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mt2MDYVJsF-ApJmgFU8;
        Mon, 30 Sep 2019 15:10:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1569845451;
        bh=QljZ0rZLNbLxvK9+AAf8gBHz/Z0scpWrbTgKp/r7k0A=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=M3sfQmqucOD1CXkmHv6xEzYjssH6a88EWIUhXwMX3EFLfW9Ff3QUcXifZNAZ/wvH+
         aLgtjd2S9GU1JELH3+73IKI+Tu6EfpBqbmFlZ7QcoanhhVi9gCoAxNmE6/B4smZofZ
         Byi97sDeK3x0hRl0kehKLFAvj+7ZcChQIPJu0yOE=
Authentication-Results: mxback3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva7-f08b2a8dca2b.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id UVUOILCfaa-Aoru1hTb;
        Mon, 30 Sep 2019 15:10:50 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Btrfs partition mount error
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
 <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
 <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
 <c9d71bdd-7fe2-faaf-23c0-ede163c1d04a@gmx.com>
 <c3ecfeb9-2900-3406-4d92-e40021753310@yandex.ru>
 <1ca0434b-3ae6-bbbe-efd3-06cab9089782@gmx.com>
 <fb259ee2-c9e2-f44d-ce5b-b3f688565c28@yandex.ru>
 <bf5265b7-96a1-5f98-07f8-947b981ac364@gmx.com>
 <245b13f7-20c9-3ab4-6e9f-0ed32f4d1c79@gmx.com>
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Message-ID: <27515deb-5225-4349-2406-132b5190f7cb@yandex.ru>
Date:   Mon, 30 Sep 2019 15:10:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <245b13f7-20c9-3ab4-6e9f-0ed32f4d1c79@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> 
> We have another report internally about a similar corruption (multiple
> bit flips in a single fs), and they are also using VMware, along with
> VMware guest kernel modules.
> 
> Would you mind to migrate to KVM based hypervisor to see if the
> corruption happens again?

I had this problem with btrfs after more than a year of using btrfs and vmware.
If I switch to KVM based hypervisor, then I am not sure that this problem will occur again
in a short period of time.
I used virtualbox earlier, but switched to vmware because virtualbox has slow graphics.
