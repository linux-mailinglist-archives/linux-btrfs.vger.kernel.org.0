Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8167363765
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Apr 2021 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhDRTqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Apr 2021 15:46:21 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:61098 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhDRTqV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Apr 2021 15:46:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 5EE93BA4;
        Sun, 18 Apr 2021 21:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1618775149; x=1620589550; bh=dEQNKaSzspTk5p5h73DZz5WgSXf66U5J/lz
        sK+zrYHA=; b=yqbNNG0uP/EE7sriIhxEH5Td+Kp56BZvlBd8rc0DQpsZbWHPwh5
        jSGoekSiYvI8fpSUpHx+RB0YYFR/TwG0T8MIVQkmoJYYe1aNPHhFDmOKPzQC52Vv
        EGEQusZ9HfG3gF/OnfmuAV+8COxymfDQoiM2K1yasLVDrt/m+IshpRNCZ59ScpH6
        BBpJOl9O0LAIOK/Knzst7fnBT+QbWgFQzTTGi++tghLZ0mmh37+09/6lop9KQSQV
        s7f0YBsfwhcuGkDgO92DJb02ZFdu34UIhrej861eX8bvJrwtG1BFcGe0aJyrY9Fc
        ZSj9Yg4dsNeUjuMyB1AXP0gleW8szomy0F6OCGj+byrqnB3rTMMdQyj7eZaq8p+Y
        VLToG4RpjiVuXpTy/5UlUhsd1OImvApqczcydGNPishQOtsV2TF+5pOlxFJpJ3G6
        vv/KLG6TvaatI/EgE+3ewQTZ5x4uIUGnhap9pOAe4nzu7oeFzvYHAV4Y3BJ+LvaP
        bmtNbl0Zvnu2a/O6zbfqYoCUe9mNsetw+l9oKEzhO4Ba77uJQbrq8Yg3eO0QmBqL
        DY5md7gd9byBDymqqhI4G7WyUyAYQ2ewiCCsWHJR1Rp4pJQ1HvUBHtgKqDecGmr9
        3gij8UTVCqCT1RYehXjiciGpGwewdqkEjpTgwfCUQ7ROIgibA7498GRY=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DoFHeez8c-jt; Sun, 18 Apr 2021 21:45:49 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 8EF521AB;
        Sun, 18 Apr 2021 21:45:49 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id DA9B01B5C;
        Sun, 18 Apr 2021 21:45:46 +0200 (CEST)
From:   Thiago Jung Bauermann <bauermann@kolabnow.com>
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 02/42] btrfs: introduce write_one_subpage_eb() function
Date:   Sun, 18 Apr 2021 16:45:39 -0300
Message-ID: <4000966.DSVRgzW4bi@popigai>
In-Reply-To: <a442f0df-d4d7-50ca-e4c3-224200ef9a70@gmx.com>
References: <20210415050448.267306-1-wqu@suse.com> <7cff2211-b74a-647e-12f5-fb5994d9f3f0@toxicpanda.com> <a442f0df-d4d7-50ca-e4c3-224200ef9a70@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Em quinta-feira, 15 de abril de 2021, =C3=A0s 20:25:32 -03, Qu Wenruo escre=
veu:
> On 2021/4/16 =E4=B8=8A=E5=8D=883:03, Josef Bacik wrote:
> > Also, I generally don't care about ordering of patches as long as they
> > make sense generally.
> >=20
> > However in this case if you were to bisect to just this patch you would
> > be completely screwed, as the normal write path would just fail to write
> > the other eb's on the page.  You really need to have the patches that do
> > the write_cache_pages part done first, and then have this patch.
>=20
> No way one can bisect to this patch.
> Without the last patch to enable subpage write, bisect will never point
> to this one.

Maybe I don't fully understand how bisect selects the next commit to test,
but isn't it possible to randomly land at this patch while bisecting an
issue that isn't even related to btrfs?

Thanks and regards,
Thiago Jung Bauermann


