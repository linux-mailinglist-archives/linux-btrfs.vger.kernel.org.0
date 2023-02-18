Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC969BA81
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 15:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBROzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 09:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBROzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 09:55:18 -0500
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBC515CA7
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fsf.org;
        s=mail-fsf-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:References;
         bh=HjIjFRDh+WKpCYLGkZadh/Hh+043twXBfn+uxQOqEkI=; b=sakteT2KdMr8KrXgzNBwbw/Az
        Ksni+oAZjdsnDf8ZjVO6jMpxEXPDKXUPbdQlUCXgP+1kZDytYVL6usJKAVIPY9J52aZl/0gpFLbVq
        pUQGKntvpSsEaDsjz2lnrgLm4yG+01vLkGmb8BnOf+ZQIogwEg5yqsAlmOdjO9lKr7dYAQJLFG/uQ
        GGLuhi2IGnOf72A3Cxt8kpc7u1qDL6XKXit3ap0bdj/ez63RP/a+Wpe/uGmTnGO0hfEfhQIbybLjf
        l2qWTC7HHfX5r0mG+lNThUxNxsWNeux6nFpsICgEbfzdVG8mLdswkHpj5sIb7TfZC4lZoEzOVHwx3
        liG/b3OTw==;
References: <87mt5y4uyj.fsf@fsf.org>
 <c5a798e3-4b58-a074-01a4-def09f136d38@gmail.com>
User-agent: mu4e 1.9.0; emacs 29.0.50
From:   Ian Kelling <iank@fsf.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: bug: btrfs receive: ERROR: clone: did not find source subvol
Date:   Sat, 18 Feb 2023 09:42:00 -0500
In-reply-to: <c5a798e3-4b58-a074-01a4-def09f136d38@gmail.com>
Message-ID: <87cz67nhv6.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry I didn't reply sooner, I was about to go to fosdem and I needed
data copied over to my laptop, so I deleted the offending subvolumes
knowing the issue would reoccur. It has now with the same 2 machines.
Here is the information I posted before, but with the new iteration of
the error, the only notable differences are the various timestamps and
uuids:

# btrfs send -p '/mnt/root/btrbk/q.20230218T054921-0500' '/mnt/root/btrbk/q.20230218T060025-0500'

on receiving host:

# btrfs -v receive /mnt/root/btrbk
At snapshot q.20230218T060025-0500
receiving snapshot q.20230218T060025-0500 uuid=f98f24ce-03ef-2b44-be4e-599c45fc3965, ctransid=553735 parent_uuid=11c71068-830b-044a-b032-3cc12947d88f, parent_ctransid=553712
write p/c/.bh - offset=5484544 length=1143
write p/c/firefox-swf-profile/cookies.sqlite - offset=131072 length=49152
write p/c/firefox-swf-profile/cookies.sqlite - offset=180224 length=16384
write p/c/firefox-swf-profile/formhistory.sqlite - offset=0 length=32768
write p/c/firefox-swf-profile/formhistory.sqlite - offset=262144 length=32768
write p/c/firefox-swf-profile/formhistory.sqlite - offset=458752 length=49152
write p/c/firefox-swf-profile/formhistory.sqlite - offset=507904 length=16384
write p/c/firefox-swf-profile/formhistory.sqlite - offset=655360 length=49152
write p/c/firefox-swf-profile/formhistory.sqlite - offset=704512 length=16384
write p/c/firefox-swf-profile/formhistory.sqlite - offset=1212416 length=32768
write p/c/firefox-swf-profile/permissions.sqlite - offset=0 length=32768
write p/c/firefox-swf-profile/permissions.sqlite - offset=98304 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=0 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=98304 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=557056 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=1343488 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=1703936 length=49152
write p/c/firefox-swf-profile/places.sqlite - offset=1753088 length=16384
write p/c/firefox-swf-profile/places.sqlite - offset=21659648 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=21987328 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=22216704 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=22675456 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=23429120 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=23494656 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=23756800 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=23986176 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=24182784 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=25526272 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=26247168 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=26312704 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=26902528 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=28409856 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=28508160 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=28672000 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=28966912 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=29065216 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=29491200 length=49152
write p/c/firefox-swf-profile/places.sqlite - offset=29540352 length=16384
write p/c/firefox-swf-profile/places.sqlite - offset=29556736 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=29753344 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=29884416 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=29949952 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=36569088 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=37683200 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=41156608 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=41385984 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=41418752 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=46006272 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=46104576 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=46235648 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=46268416 length=32768
write p/c/firefox-swf-profile/places.sqlite - offset=46301184 length=49152
write p/c/firefox-swf-profile/places.sqlite - offset=46350336 length=49152
ERROR: clone: did not find source subvol



Andrei Borzenkov <arvidjaar@gmail.com> writes:

> On 31.01.2023 17:02, Ian Kelling wrote:
>> on sending host:
>> btrfs send -p /mnt/root/btrbk/q.20230126T000018-0500 /mnt/root/btrbk/q.20230130T200019-0500
>
> Show output of
>
> btrfs subvolume show /mnt/root/btrbk/q.20230126T000018-0500
> btrfs subvolume show /mnt/root/btrbk/q.20230130T200019-0500

Using the subvolumes of the current error:

# btrfs subvolume show /mnt/root/btrbk/q.20230218T054921-0500
btrfs subvolume show /mnt/root/btrbk/q.20230218T054921-0500
btrbk/q.20230218T054921-0500
	Name: 			q.20230218T054921-0500
	UUID: 			f41b8364-5c1f-d74d-aa68-a44298993f65
	Parent UUID: 		cc4f736a-b3c0-6a49-846d-f1e7c77bd27f
	Received UUID: 		11c71068-830b-044a-b032-3cc12947d88f
	Creation time: 		2023-02-18 05:49:44 -0500
	Subvolume ID: 		12734
	Generation: 		553712
	Gen at creation: 	553708
	Parent ID: 		5
	Top level ID: 		5
	Flags: 			readonly
	Send transid: 		433889
	Send time: 		2023-02-18 05:49:44 -0500
	Receive transid: 	553709
	Receive time: 		2023-02-18 05:49:44 -0500
	Snapshot(s):
				q
# btrfs subvolume show /mnt/root/btrbk/q.20230218T060025-0500
btrfs subvolume show /mnt/root/btrbk/q.20230218T060025-0500
btrbk/q.20230218T060025-0500
	Name: 			q.20230218T060025-0500
	UUID: 			f98f24ce-03ef-2b44-be4e-599c45fc3965
	Parent UUID: 		4771b096-9488-3f4a-a894-cde735111183
	Received UUID: 		-
	Creation time: 		2023-02-18 06:00:37 -0500
	Subvolume ID: 		12739
	Generation: 		553736
	Gen at creation: 	553736
	Parent ID: 		5
	Top level ID: 		5
	Flags: 			readonly
	Send transid: 		0
	Send time: 		2023-02-18 06:00:37 -0500
	Receive transid: 	0
	Receive time: 		-
	Snapshot(s):


>
>> on receiving host:
>
> Show output of
>
> btrfs subvolume list -uR /mnt/root/btrbk

That lists a lot of unrelated subvolumes, I narrowed it down:

btrfs subvolume list -uR /mnt/root/btrbk | grep -P 'path (btrbk/q\.|q$)'
ID 9407 gen 424001 top level 5 received_uuid -                                    uuid c73d6305-d71a-024a-9905-e1c8bb8a029b path btrbk/q.20221218T210012-0500
ID 9714 gen 424001 top level 5 received_uuid 35ebfa2d-f1ba-5f4f-8ae1-6b7ee78e7e87 uuid 83a9cd45-081b-ea4e-b247-40e79c2080e7 path btrbk/q.20221225T000021-0500
ID 10173 gen 424001 top level 5 received_uuid a079d502-03ad-8344-ba86-23d0d8025dc8 uuid 988af5bf-831f-0d4e-9db3-2a600f9984aa path btrbk/q.20230101T000019-0500
ID 10710 gen 424192 top level 5 received_uuid -                                    uuid 8c19d1ba-97ac-0540-ac79-d7ea281aedbe path btrbk/q.20230108T000017-0500
ID 11319 gen 424192 top level 5 received_uuid bc951b3f-6ce4-dd4b-85ca-7e3e3cf2016a uuid 1ff39f4c-9ad1-024c-933c-34f08c05ebd4 path btrbk/q.20230115T000023-0500
ID 11693 gen 424192 top level 5 received_uuid d04eca55-42cd-1742-88f6-4e48b4fbdf3c uuid 2adee47b-5eb9-8e43-9cba-e1d7c9a9b681 path btrbk/q.20230123T080020-0500
ID 12058 gen 424192 top level 5 received_uuid 77304ad5-ed1f-164e-9923-612dbb92376c uuid 823148ae-ec29-2947-bd34-b27bbe91267b path btrbk/q.20230130T200019-0500
ID 12219 gen 424192 top level 5 received_uuid -                                    uuid 7513a7d3-15e9-804b-ba1c-55ba50f7ea92 path btrbk/q.20230204T000006-0500
ID 12267 gen 424192 top level 5 received_uuid -                                    uuid ff3e022d-948d-f142-b58d-15b7a546972b path btrbk/q.20230205T000006-0500
ID 12308 gen 424192 top level 5 received_uuid -                                    uuid 9e057038-dae1-f046-808e-ae1bd20d6cdb path btrbk/q.20230206T100008-0500
ID 12343 gen 424192 top level 5 received_uuid -                                    uuid e9271ada-c4dc-6347-9b8a-2486f5b105a9 path btrbk/q.20230207T060008-0500
ID 12429 gen 424192 top level 5 received_uuid -                                    uuid 3287fa82-303e-284e-91b0-4312c0807973 path btrbk/q.20230208T000008-0500
ID 12456 gen 424192 top level 5 received_uuid -                                    uuid 0c64b911-001d-b44e-9fdc-12f50e73e544 path btrbk/q.20230209T000017-0500
ID 12490 gen 424192 top level 5 received_uuid -                                    uuid b0f6b97f-76a4-694e-985c-cc176b1d5e3b path btrbk/q.20230210T000017-0500
ID 12533 gen 424192 top level 5 received_uuid 49392969-6193-8c47-b525-45756f46d111 uuid efbe102a-8b33-1943-921d-233adad00286 path btrbk/q.20230211T000030-0500
ID 12534 gen 424192 top level 5 received_uuid dd610a39-d0a5-0047-bf1e-27bd10f17d9a uuid 7abb2b2d-816d-a944-a7e9-29e5be16eb61 path btrbk/q.20230212T080020-0500
ID 12582 gen 424165 top level 5 received_uuid 58e912fe-1161-b543-9014-3035ec76d6dd uuid 39cd2cf1-f81b-f94b-9d26-593dc8831f90 path btrbk/q.20230213T000021-0500
ID 12654 gen 424165 top level 5 received_uuid 789169fb-5f08-9e49-bab3-e016c67e6f7d uuid 738f886d-5e57-2747-a75e-e4543d97be90 path btrbk/q.20230214T000022-0500
ID 12730 gen 426574 top level 5 received_uuid 22251827-86eb-a748-b9a3-d10a629f4825 uuid 0d89c062-7a88-544d-bd4c-d7c7b6eefafc path btrbk/q.20230215T000022-0500
ID 12791 gen 429107 top level 5 received_uuid -                                    uuid 474ce40f-0cd9-7c4f-8796-4905a59b8f64 path btrbk/q.20230216T000019-0500
ID 12841 gen 431664 top level 5 received_uuid -                                    uuid a95ffdeb-f119-3f45-995f-8f20b8ffbac0 path btrbk/q.20230217T000013-0500
ID 12869 gen 432802 top level 5 received_uuid 90c38844-0e82-a043-a1ba-42dccdd8ff6a uuid ad8ed7ed-b966-8042-85c3-55b18a82e079 path btrbk/q.20230217T110028-0500
ID 12870 gen 432805 top level 5 received_uuid eb503c6b-8037-2749-b426-c8d819282da7 uuid 72da80c6-4194-1440-a4ef-8200a009d4d4 path btrbk/q.20230217T120027-0500
ID 12871 gen 432808 top level 5 received_uuid a3b2fbac-2a53-d847-8820-df15365ab0f7 uuid f87e4a48-6bce-6543-af38-0a7eb1f0f610 path btrbk/q.20230217T130028-0500
ID 12872 gen 432811 top level 5 received_uuid 0ad7d50d-aaa5-184e-a85d-8e720ea17602 uuid 95893850-9240-4643-8994-27127f454d85 path btrbk/q.20230217T140027-0500
ID 12877 gen 432833 top level 5 received_uuid -                                    uuid aae679e8-60d0-c54f-b1d0-488a65d7bd16 path btrbk/q.20230217T150021-0500
ID 12879 gen 432990 top level 5 received_uuid -                                    uuid 4a3d1300-fe37-074f-bc87-9733c87ec55e path btrbk/q.20230217T174534-0500
ID 12884 gen 432993 top level 5 received_uuid ab36acd8-402e-1f48-91e9-7ee84a689a32 uuid 14e8d9f7-a718-dd43-8698-7b593532a18b path btrbk/q.20230217T180028-0500
ID 12885 gen 432996 top level 5 received_uuid 3887c8f6-e14e-4e44-9621-29435fa7cfb9 uuid 749f3f49-1a3f-3949-8239-37907f6d7f1b path btrbk/q.20230217T190026-0500
ID 12886 gen 432999 top level 5 received_uuid a6164fd8-d7f4-b547-bdbd-4c437051f966 uuid 80f6acff-010d-8944-90e2-03a6af8549b9 path btrbk/q.20230217T200028-0500
ID 12888 gen 433895 top level 5 received_uuid -                                    uuid 4e0f0bd5-0a43-0440-b272-6c9d4b06e489 path q
ID 12891 gen 433033 top level 5 received_uuid -                                    uuid 0d776c9a-a4b5-994b-8a0a-56224f36b599 path btrbk/q.20230217T210023-0500
ID 12893 gen 433195 top level 5 received_uuid -                                    uuid 38f25e4d-e5de-4c4d-a011-4490b34b899e path btrbk/q.20230217T230015-0500
ID 12895 gen 433300 top level 5 received_uuid -                                    uuid c5c5ccbc-e402-714b-a2d5-a1832169b37a path btrbk/q.20230218T000014-0500
ID 12897 gen 433403 top level 5 received_uuid -                                    uuid 82410a19-9a65-3348-8f81-135df27c3043 path btrbk/q.20230218T010015-0500
ID 12899 gen 433507 top level 5 received_uuid -                                    uuid 79c83786-0d36-6643-8db7-bf387c78ffa8 path btrbk/q.20230218T020017-0500
ID 12901 gen 433609 top level 5 received_uuid -                                    uuid e7c8c3b4-1ae1-be44-a0ad-88d112bc7e67 path btrbk/q.20230218T030017-0500
ID 12903 gen 433708 top level 5 received_uuid -                                    uuid ac35015a-1ff6-394f-88f5-0d7cc394a089 path btrbk/q.20230218T040016-0500
ID 12905 gen 433811 top level 5 received_uuid -                                    uuid 6ede5b66-9c0e-724d-be87-fe52dbc29155 path btrbk/q.20230218T050014-0500
ID 12907 gen 434221 top level 5 received_uuid -                                    uuid 11c71068-830b-044a-b032-3cc12947d88f path btrbk/q.20230218T054921-0500
