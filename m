Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC95373CD0
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhEEOAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 10:00:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57313 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232923AbhEEOAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 May 2021 10:00:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 69E565C0187;
        Wed,  5 May 2021 09:59:05 -0400 (EDT)
Received: from imap5 ([10.202.2.55])
  by compute3.internal (MEProxy); Wed, 05 May 2021 09:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm2; bh=1B/MDieHYAtaNQggohZ0z7I28qMBXpS
        BHKSutPMqhKc=; b=KmuJeqvcQAcoa5yFwwX9YoK9IveSFAn3337l281GYHGcsp/
        6mSg+Hr2sep5FDD17Rp+Z90q6a4IqEO2xSt2ggBB1Q22QbjblI91k2PblkMqIwu2
        Wx84ZpVTmBXEHPgtsVGIczMLM/Y8e4/t3HaAsHdAMS2DZN0vLG+ix+W51V30PjK/
        itUqsnkW7jczZ1N5977rAJNW9+vqH0C0pKq5j4MnxPMTAIRRrw1cx6+/urOyrrRm
        TtujGLxkxzjpv2AmEJM+c8bWSC9isqasssTsND7cKmpXrxoNv5UeB9blFPebzfWw
        TKd6s3s4VvhL/hVp/Q8H1XJMmKNJ0sEh9nurTtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1B/MDi
        eHYAtaNQggohZ0z7I28qMBXpSBHKSutPMqhKc=; b=KCHI1SX4gYVUukYX+3zCjn
        UhzRgDiIXL+vrSkdFspvNItsWA6cKXoF/Hv5EaAYrDV6M2hEEeNrY9DU7qo5mX+p
        nQ2zs1whP+4N3/5ZMMKGFiYlS3ZZ+ufsiVRMujZSxjqlad+cdjOPT9SQGUf8vaR6
        HN+TyO0VNXt0hUVbBZenu0IImN4SRVRKSStHn2jCrY6dlQRF/9bJi/OlDho+xbD9
        QirkomIE7ILQtXma1a3RuDth7w4oGgFVrSW2J4vZoxbRvnNGvAiHpsK+aYICtiXH
        7cgYZYIEAqKI3OCsW5K+8YiopdLPKbvZUfcdfKiMWsmo/ro4IQ3YzenkbjP9yRXQ
        ==
X-ME-Sender: <xms:qaSSYJVU-69TQcRDJfBJOReIR9KD5wTcIPxScD7Q4Jtd3G8iTsY3qQ>
    <xme:qaSSYJn9UjMZuoqMzP_Tb6sF6xd_1aRvf9v0eub6ecrmi6CrVGu1HQ24rM-aKWKzm
    giyqEVzN8_yJj8Djw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefkedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhmnecuggft
    rfgrthhtvghrnhepuefgfeevgfduffekudfhledvieeffeelgfekgeelffdvkeelvdekgf
    dvudejffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:qaSSYFbImdiuAScIMtqNXecXecuWlY1naK4qvHXlAVtN_uQOpTtu3A>
    <xmx:qaSSYMX8ouskS-f0jIiP1jwS3pBkdqHkpfyN4i_EYaKYrZKhIt5xIg>
    <xmx:qaSSYDliXtslstgXL9bLabazLDlfvOyiRlx2oDtJ4uOwNrXjqdFCyw>
    <xmx:qaSSYJTqFUepGPP1j8BnkM7-8EdsgdE3SMEarh9YHsQf67kokIh_Qw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3969BA0085; Wed,  5 May 2021 09:59:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-442-g5daca166b9-fm-20210428.001-g5daca166
Mime-Version: 1.0
Message-Id: <5b563f2f-9057-44cc-8ec8-5367548aef6f@www.fastmail.com>
In-Reply-To: <CADOXG6Fj3zCzu46q-nLKOdszxQHPGLk6r5rDn80KNLKY5sn3iQ@mail.gmail.com>
References: <CADOXG6Fj3zCzu46q-nLKOdszxQHPGLk6r5rDn80KNLKY5sn3iQ@mail.gmail.com>
Date:   Wed, 05 May 2021 09:58:03 -0400
From:   remi@georgianit.com
To:     "Abdulla Bubshait" <darkstego@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Array extremely unbalanced after convert to Raid5
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Wed, May 5, 2021, at 9:41 AM, Abdulla Bubshait wrote:
> I ran a balance convert of my data single setup to raid 5. Once
> complete the setup is extremely unbalanced and doesn't even make sense
> as a raid 5. I tried to run a balance with dlimit of 1000, but it just
> seems to make things worse.

> 
> Unallocated:
>   /dev/sdd       14.12TiB
>   /dev/sdc      404.99GiB
>   /dev/sdf        1.00MiB
>   /dev/sde        1.00MiB
> 
> 


Sorry, I don't have a solution for you, but I want to point out that the situation is far more critical than you seem to have realized.. this filesystem is now completely wedged, and I would suggest adding another device, or replacing either /dev/sdf  or /dev/sde with something larger,, (though, if those are real disks, I see that might be a challenge.)

Your metadata is Raid1C3, (meaning 3 copies,), but you only have 2 disks with free space.  And thanks to the recent balancing, there is very little free space in the already allocated metadata,, so effectively, the filesystem can no longer write any new metadata and will very quickly hit out of space errors.
