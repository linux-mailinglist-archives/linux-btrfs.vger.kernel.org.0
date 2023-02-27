Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A076A46E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 17:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjB0QW4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 11:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjB0QWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 11:22:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83372D4D
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 08:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677514971; i=philipp.gerlach@gmx.de;
        bh=rjJgrXxXHOa3/9YzvGAZGcHgD8lb78+QIiU1ZW+cL8c=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=slv0fMlhXXaP+oB8s2wXQVjO0atX6j1E2M/vdTRHigqpjX7ZJNkoTAHAhn5rCwzhv
         cVGKGoz85tBrQ7SAAdKbQnkNEeD4wF8UPVVSEc95LykvbSCjvmdnbL4PS69OO8OvIz
         +ccK6YnomR/aa2N5mhNg2EWHnXKF48L7IHURvh1ItdMCSp5yteQNazvzwGEEFsWOie
         I46ogAKMb90E9U03hgjhNg7B3cZkS4gnf3yE58wdQ6mdKHAM0Gdj62yGn2s7ENIQJM
         J7mmeOK/ji4Yq9Bi4sh6iePKWPsQI69SM22Q9SjahLtWglbdH8nWDPkUdy6AsUoXvB
         iZg3xnBvXZh6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.128.23] ([93.229.118.199]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1pJUzq3xp2-00DDG3 for
 <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 17:22:51 +0100
Message-ID: <05b1de7a-a8f1-0cda-4519-ffdd0576a555@gmx.de>
Date:   Mon, 27 Feb 2023 17:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Betterbird/91.12.0
Content-Language: en-US
From:   Philipp Gerlach <philipp.gerlach@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: Question / Idea regarding fragmentation caused by COW operations
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eVfoI2WlqJ0FyeGcLDhs+Jz8hrZaq6TKr1xa92ppUSCF1Q799wc
 c23H+9uoF/qsbNkzAM8UZu02wog1jLNqOUg1DkqUIp3aKJaXmgJwUmCTuU++4NJNWznjUK4
 bIr2i+vXpGiQkfLUdjizj+hDWN4ROX3+nKERXRJiI6L9pqw73HtlNfZ4GptLrcoHxAzIJqO
 oTgZnkXlq+BXPYjduhwLA==
UI-OutboundReport: notjunk:1;M01:P0:aOyBVyoB2tU=;4VvMVsIloksJngctKJ7pjSVTkkZ
 FHnH4PDAFG/3NxM+Lh92rEJv7BdexZlx5QWGP4uKn0foTEjsfx/pCWRxJ+kujhlM0o866EMnb
 MKVKfkZ4j/ew5NDgy7Nv9G3n5d4SQ8AvYZLO8EudIPN+cQYXe6CxP+eb07JWZWZrbYkk1CndG
 7ov7bw4gguNBjcC/NCYxJ5MfdSiZk3NdGmUlgp/m8VDuo7/iTCpY98RTNItwvTb6rxcbVb/H0
 dYUP6attPDJYAPS8tYELCNjTaawDRpNHvT9z0dP65MYwU0gBOQuq33UTA9ajVDD4T04ex7+bs
 und/dnFI0ElxaxatpKjKYT3LJQvu/JUDN3/x5Pgqy/oCSM1HUTpNYkwRuoUujbiCQqD9hBqgs
 u52hq4v8WKSTUUTAVOCa6G7uJCwqLNkW8Jm8qTc1h/PLCOitLFqrEGLRtnwRCNMtwO793HoD0
 +sGyJ54ptkWodzURkpUo94407CuGwyj4qCmiuMrnsiLwc/YaS5FD14LyXky1akGnkFhKGVMJs
 WL4RU5ldLfJdB83mtIonf1tphrY+eGfqZVrPI3Y6WlgVHJMrjhChV6uIiMnImyFrQdH123DPU
 YEq7Gn6Q+erbkF9PNtvbZWNtwmV+qTlaY6+NFFJaMwH4veT7djOsD9rlCEbS4MpRU/d6yKCsv
 EDBNi0v2SlSNuiSRpZzHZ7Sg8rOYlhWUNt35TG08VUskzp+XmV67C30b8tssfVbNYQXiKyCCs
 y+MUYtSP67g9iEenX2AcTwnlREdGhyETh0M9BsSg3hFoEA2FNVt5wMh66aRu48O5h0oxEuR2Z
 jGHyzy1KqP/01Ocn864A0qEsTx7lebC/xV5pTEIi4cFljl4KKZpBihTgBPX+RBn4FQXfFed8I
 1VY2FQHCocnvdUbK5fvyFD9W0r/j99SEC5omMy8R7C2EzL/AMpkh63IeX93gCCkviepF048v+
 /rpUpJI1YPsWdncYNGV/QgWTVaw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a question, maybe an idea for a feature, regarding the way how
COW is causing fragmentation of files.

As I understand it, COW in btrfs works roughly like this:

A file=C2=A0which -- because of its size -- uses several extents is edited=
.
That means that the data within one of the extents will be changed.=C2=A0T=
he
changes are not written to the original extent, but the changed data for
the extent is written to a new location. Afterwards, the reference to
the extent is updated and will then point to=C2=A0the new extent in the ne=
w
location, and pointing to the other unchanged extents in their original
location as before.=C2=A0This way the extents of the file are partly in th=
eir
original location and partly in a new location, i.e, the file becomes
fragmented.

Do I understand this more or less correctly?

My Idea is the following:
I assume that in many use cases the newest version of a file will be the
one which is most often read and most probably further edited. Older
versions are probably mostly kept for backup / snapshots / archive, so
one could assume that they are rarely read and even less edited.

Therefore it may be beneficial to switch the way extents are written:
1. Instead of writing the changed extent to a new location, copy the
original extent to a new location
2. Update all existing references to that extent to point to the new
location
3. Then write the changed extent in the original location
4. Update the reference to the extent for the file which is currently
edited to point again in the original location

This would mean that one has to pay a bit in terms of performance=C2=A0whi=
le
writing, especially for extents which are referenced a lot (for updating
the old references), but on the upside fragmentation would probably only
rarely be encountered while reading. Plus, if e.g. older versions are
indeed only used in snapshots for versioning purposes, the fragmented
files would be deleted over time when old snapshots are deleted regularly.

Does this make sense?

Best regards
Philipp


______________________________________________________________________

Dr. Philipp Gerlach

philipp.gerlach@gmx.de
______________________________________________________________________

