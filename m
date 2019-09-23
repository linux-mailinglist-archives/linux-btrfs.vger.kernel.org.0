Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4765FBBF26
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 01:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391592AbfIWXy2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 19:54:28 -0400
Received: from know-smtprelay-omd-9.server.virginmedia.net ([81.104.62.41]:57280
        "EHLO know-smtprelay-omd-9.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfIWXy1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 19:54:27 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id CY9yifkiLVaV8CY9yit5EU; Tue, 24 Sep 2019 00:54:26 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=PcnReBpd c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=f8L713TMx6d023-uD2wA:9 a=QEXdDO2ut3YA:10
Subject: Re: Balance ENOSPC during balance despite additional storage added
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
 <CAJCQCtRAnJR+Z8Z8Bq91YXiMpfmwOiHK0tQ+9zAJvSVvexHnxg@mail.gmail.com>
 <54fa8ba3-0d02-7153-ce47-80f10732ef14@petezilla.co.uk>
 <CAJCQCtQLk1m8yAxPPDLVZBr3MehdDD3EpNZ6O_OCRsO-FFzRNw@mail.gmail.com>
 <eb9fdaee-ec76-5285-4384-7a615d3cd5c1@petezilla.co.uk>
 <00be81e2-bca2-3906-c27d-68f252a6ffe1@petezilla.co.uk>
 <CAJCQCtRbjz138p_DVX4=v0e38rtDFjpqrOhBTc4o7Mc=s_zcEw@mail.gmail.com>
 <fe29580c-3239-f338-6a27-28739fbe7415@petezilla.co.uk>
 <CAJCQCtQrLfqzraCVsMpw99CkHjbAJcfJTrKAdLg6A2G3wtzZtQ@mail.gmail.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <5835e532-860f-9f2b-6b63-af69bf48b0d4@petezilla.co.uk>
Date:   Tue, 24 Sep 2019 00:53:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQrLfqzraCVsMpw99CkHjbAJcfJTrKAdLg6A2G3wtzZtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPOTz6wNlHSiJl2tns3qDcg1FfOZxk9wAXeq8lCy6t9ND8FzlFEogpJ/kGXDfkQ9/gpb1U+qO2V3tzmmpn1UYtt7itTk6T96r6hyAf6qJukRTjO+/MzM
 uWDBwnez7IF/t13ZwkifbyvEDijXcEX4T6AMkyWiLVdX5n/qIDIpR2ug4MnsgK6oHfwSjP6Rxs18lfQNQjKZbgXtX7W9wF73QVE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/24/19 12:10 AM, Chris Murphy wrote:

> Since I've reproduced it with all new progs and kernel I don't think
> you need to add anything there.
> 

Thanks, appreciated.

