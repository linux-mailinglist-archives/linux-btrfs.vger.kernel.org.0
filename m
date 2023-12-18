Return-Path: <linux-btrfs+bounces-1044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CAA817F1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 02:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA2B22F0E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 00:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFA015A0;
	Tue, 19 Dec 2023 00:59:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bat.birch.relay.mailchannels.net (bat.birch.relay.mailchannels.net [23.83.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158727FB
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CD82F502721;
	Mon, 18 Dec 2023 22:38:47 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id B85935027B9;
	Mon, 18 Dec 2023 22:38:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702939127; a=rsa-sha256;
	cv=none;
	b=Af6V3cwOdxybF76yyl6anQKefXoE+d8f2JACcDrVsesjw0Y66hbbTkLmgKX2Bh1oL7NM/2
	yqED4xDd3XXwv/uB4to0lZ16EFEhV1ZIQXVsuo8sr/3FJ3FF9whmWrOu1W7hlIWoYD4GDo
	gaIImJ/Ov/iSu7pklz6/Yj9nSKT28OJjwAEyeMZIJxx2KhxIeSGH6RNIKziMDJjRD75Mle
	HPCMp0++TxvuNoF4mIhFcTZblQ5uqfUU2W3cBoerEM3COsnB2+yI0wqcrVqHgn11j8yagz
	GAfze3WWG3+bLq2EzUXWKRhin3N6HXFbYDwPTjDQPqyMdBx0LDYsClH5EXMZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702939127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dFS4DQktWxKbf8W3k7C+GXr2qBYDNUe0wrNqVAiF/Ds=;
	b=anRx9bwUABWR2TrHn5Yz9dONjQ+PukJy8r/4JY0CCBGvfITh4bN0DxDdkJVV9JpTwnX/HC
	2PC/gWhpphK3Ne8ynShxP1t0Ly/2Ahg22bS0tLFkTrZk8RW5cGq5WLPAz60A6DMzYMHwsW
	RsJXuuzqS4804Ace66qT2w0igRm+sfs824E7U28694mjSdAfJ9CgP8JxWi9q9AoIlzEg35
	8ovicGpLGgSVrvcw8heJMFfumCGhtZIUWnR+auw/qZeNNJTjjASBkdxl2HEjl2KCF8BDMf
	J9NePZoJBxKWk/JE2/O39I79XQlveCzgur53yZmHnL7Q/F+U2P/dHZy1nRbRFA==
ARC-Authentication-Results: i=1;
	rspamd-659dcc87c8-bzm68;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Junk
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stupid-Average: 617d3e2e10a8b9ec_1702939127701_2483879060
X-MC-Loop-Signature: 1702939127701:879325811
X-MC-Ingress-Time: 1702939127701
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.107.188.194 (trex/6.9.2);
	Mon, 18 Dec 2023 22:38:47 +0000
Received: from p5b0ed5dc.dip0.t-ipconnect.de ([91.14.213.220]:59122 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rFMG2-0004e6-12;
	Mon, 18 Dec 2023 22:38:45 +0000
Message-ID: <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: kreijack@inwind.it, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	linux-btrfs@vger.kernel.org
Date: Mon, 18 Dec 2023 23:38:38 +0100
In-Reply-To: <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
	 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
	 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
	 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
	 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
	 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
	 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
	 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
	 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
	 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
	 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
Content-Type: multipart/mixed; boundary="=-8wc86td02emPTSWeNWXw"
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

--=-8wc86td02emPTSWeNWXw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey.

On Mon, 2023-12-18 at 20:18 +0100, Goffredo Baroncelli wrote:
> Being only 309 files, I suggest to find one file as test case and
> start to inspect what is happening.

I made a small wrapper around compsize:
#!/bin/sh

while IFS=3D'' read -r file; do
        tmp=3D"$(compsize -b "$file" | grep '^none' | sed -E 's/ +/ /g')"

        du=3D"$(printf '%s\n' "$tmp" | cut -d ' ' -f 3)"
        ref=3D"$(printf '%s\n' "$tmp" | cut -d ' ' -f 5)"

        delta=3D"$(( $du - $ref ))"
        if [ "$delta" -ge 524288 ]; then
                printf '%s\t%s\n' "$delta" "$file"
        fi
done

called like:
# find /data/main -type f | ~/compsize-helper=20
252653568	/data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/=
000001
217198592	/data/main/prometheus/metrics2/01HHFFHGP4SDPEGGY4ME3GT0Q7/chunks/=
000001
107094016	/data/main/prometheus/metrics2/01HHFPD50EKCPVC2WZCP006WDV/chunks/=
000001
121311232	/data/main/prometheus/metrics2/01HHFX8YPK0D55GRM4V5TN46J3/chunks/=
000001
106512384	/data/main/prometheus/metrics2/01HHG44J1F5R8K3527V2VVT5VA/chunks/=
000001
102907904	/data/main/prometheus/metrics2/01HHGB0A32RWYKWZBDVMH7NG70/chunks/=
000001
105345024	/data/main/prometheus/metrics2/01HHGHW20CFYANMMNF1DGSMQE2/chunks/=
000001
105590784	/data/main/prometheus/metrics2/01HHGRQSR0M0F53JJBKZH52S7H/chunks/=
000001
106688512	/data/main/prometheus/metrics2/01HHGZKJEXEKW3594B74DR9NTH/chunks/=
000001
106213376	/data/main/prometheus/metrics2/01HHH6FA6YRWC6HAJGQJX9QATF/chunks/=
000001
106409984	/data/main/prometheus/metrics2/01HHHDB1EHS6V9NYKYAMJTSXBB/chunks/=
000001
225648640	/data/main/prometheus/metrics2/01HHHM6S6JYGAXCQV9XVMGMW83/chunks/=
000001
107253760	/data/main/prometheus/metrics2/01HHHV2DZYXNFZ5PRHB2M12E7Z/chunks/=
000001
106340352	/data/main/prometheus/metrics2/01HHJ1Y5QS4DS408MMCH97WC02/chunks/=
000001
105254912	/data/main/prometheus/metrics2/01HHJ8SXF3W7DKW5N0YACG3ZWT/chunks/=
000001
104161280	/data/main/prometheus/metrics2/01HHJFNKQZ3AEZYFXWEQ5RQ3HB/chunks/=
000001
104771584	/data/main/prometheus/metrics2/01HHJPHBFVMBRB27ECMNB0J3GG/chunks/=
000001
101986304	/data/main/prometheus/metrics2/01HHJXD37EPQXB5599MHWEESMZ/chunks/=
000001
106614784	/data/main/prometheus/metrics2/01HHK48TZ2KNFNWT1VTH5HE0HF/chunks/=
000001
231501824	/data/main/prometheus/metrics2/01HHKB4K6M286JNX0QAX6M5P7C/chunks/=
000001
107102208	/data/main/prometheus/metrics2/01HHKJ07GSVRGR3B3RW7EY2M03/chunks/=
000001
106823680	/data/main/prometheus/metrics2/01HHKRVZ85RXB1TZ0M1Q3453D2/chunks/=
000001
105611264	/data/main/prometheus/metrics2/01HHKZQPZTQV3DCVQCCVH7DXGE/chunks/=
000001
104497152	/data/main/prometheus/metrics2/01HHM6KB9WNF18ZNC7JE81Z3QW/chunks/=
000001
107216896	/data/main/prometheus/metrics2/01HHMDF5FRRAX8DCNGCGTNDR98/chunks/=
000001
105299968	/data/main/prometheus/metrics2/01HHMMAVRD2BTWKCZPYZ1WD6DT/chunks/=
000001
105328640	/data/main/prometheus/metrics2/01HHMV6KZS6F476HG6DT4ZM180/chunks/=
000001
223375360	/data/main/prometheus/metrics2/01HHN22CPP9FVDZG1MGET13J4X/chunks/=
000001
224215040	/data/main/prometheus/metrics2/01HHN8Y10XMFF9M2CRPQJWG94Y/chunks/=
000001
99090432	/data/main/prometheus/metrics2/01HHNFSS84Y6C6BBVY7E3QMAZS/chunks/0=
00001
104562688	/data/main/prometheus/metrics2/01HHNPNH00AZHAV1RPB6SW8443/chunks/=
000001
107819008	/data/main/prometheus/metrics2/01HHNXH8QE32FQEMA7DDVZK8M8/chunks/=
000001
103890944	/data/main/prometheus/metrics2/01HHP4D1EBSX48Y3CY66VV703Y/chunks/=
000001
105041920	/data/main/prometheus/metrics2/01HHPB8P8AN1W5SH6ZTC90R48Q/chunks/=
000001
107278336	/data/main/prometheus/metrics2/01HHPJ4EZG9TB32P8W4MDMQSZG/chunks/=
000001
106553344	/data/main/prometheus/metrics2/01HHPS02SFZEC187ZJJDVSD1Z0/chunks/=
000001
156815360	/data/main/prometheus/metrics2/01HHPZVV0P5QCGG8QA89C36RVW/chunks/=
000001
153927680	/data/main/prometheus/metrics2/01HHQ6QJRFY0WF1K4QHM74A12S/chunks/=
000001
125075456	/data/main/prometheus/metrics2/01HHQDKBFRFFQ7J2XJ836CRHW3/chunks/=
000001
209260544	/data/main/prometheus/metrics2/01HHQMF375KTC4BWMF9RBCM6RS/chunks/=
000001
106807296	/data/main/prometheus/metrics2/01HHQVAVESRRXJ5KQ9FN8AQ0XA/chunks/=
000001
105955328	/data/main/prometheus/metrics2/01HHR26E9C5B2RYFCQPG7G7M4H/chunks/=
000001
105402368	/data/main/prometheus/metrics2/01HHR92618K1C6QCR1JP3NKRR5/chunks/=
000001
107376640	/data/main/prometheus/metrics2/01HHRFXY8DJPBQ924RJJWZB3BY/chunks/=
000001
107413504	/data/main/prometheus/metrics2/01HHRPSP069YJXRDHF3P8CPM5S/chunks/=
000001
105881600	/data/main/prometheus/metrics2/01HHRXNE7JFSYFQ3QF63WDZ0AB/chunks/=
000001
217497600	/data/main/prometheus/metrics2/01HHS4H21ZSZVA10JVDNHNQ7Q8/chunks/=
000001
108908544	/data/main/prometheus/metrics2/01HHSBCT94CC9AW1N9JQA6VF0K/chunks/=
000001
109170688	/data/main/prometheus/metrics2/01HHSJ8J18HQTQ4V45AZTSN336/chunks/=
000001
109060096	/data/main/prometheus/metrics2/01HHSS4AQMF186EXPQKT77KG8F/chunks/=
000001
108732416	/data/main/prometheus/metrics2/01HHSZZWKYJG4AQ8S6X3A0V1RF/chunks/=
000001
159817728	/data/main/prometheus/metrics2/01HHT6VMTVPDT2RMR76P642HZ9/chunks/=
000001
109006848	/data/main/prometheus/metrics2/01HHTDQD2H7VJRXBC5BA7K4018/chunks/=
000001
108662784	/data/main/prometheus/metrics2/01HHTMK68T7QSGE4MHFWBJHM1W/chunks/=
000001
201793536	/data/main/prometheus/metrics2/01HHTVEYZYPDXDZSGDM91S9QFW/chunks/=
000001
109015040	/data/main/prometheus/metrics2/01HHV2AQ7DEHX5BNSXX2VQC2TW/chunks/=
000001
109756416	/data/main/prometheus/metrics2/01HHV96BHBAP1TZY54AQ8BA0YB/chunks/=
000001
103170048	/data/main/prometheus/metrics2/01HHVG238JVD74GD07F2W87Y9Y/chunks/=
000001
210407424	/data/main/prometheus/metrics2/01HHVPXVG00GAK4E3YY6ADGDG9/chunks/=
000001
108261376	/data/main/prometheus/metrics2/01HHVXSMQ5XWWKXAK7SRR61AK8/chunks/=
000001
108457984	/data/main/prometheus/metrics2/01HHW4N72CMZ90VTVACG7QD87M/chunks/=
000001
109596672	/data/main/prometheus/metrics2/01HHWBH08ZYZRNEC38VXK9Y946/chunks/=
000001
194060288	/data/main/prometheus/metrics2/01HHWJCRG7WC5NHB684RXCNKMV/chunks/=
000001
110596096	/data/main/prometheus/metrics2/01HHWS8GQGHNWH4Z4WETJN454Q/chunks/=
000001
110592000	/data/main/prometheus/metrics2/01HHX048F9110B1CMK300XCE99/chunks/=
000001
107954176	/data/main/prometheus/metrics2/01HHX6ZTAZEQ69MGKQDSZ7TG96/chunks/=
000001
157130752	/data/main/prometheus/metrics2/01HHXDVJJG0YMR3T2ZSS7TMGPA/chunks/=
000001
122175488	/data/main/prometheus/metrics2/01HHXMQE7152WG1HARM51JPKFT/chunks/=
000001
208908288	/data/main/prometheus/metrics2/01HHXVK5YTHRVQXEHXWR1K270F/chunks/=
000001
140976128	/data/main/prometheus/metrics2/01HHY2EXPC19MBPRGM05X3ZB75/chunks/=
000001
140902400	/data/main/prometheus/metrics2/01HHY9AKFSADNWJVW4XN06QTZY/chunks/=
000001
250085376	/data/main/prometheus/metrics2/01HHYG6AQEAYV7WBSWJSSMHR02/chunks/=
000001
114298880	/data/main/prometheus/metrics2/01HHYQ22YNG446ARA9KDTJH9RP/chunks/=
000001
108421120	/data/main/prometheus/metrics2/01HHYXXT096QKW02KAAXH791SG/chunks/=
000001
109977600	/data/main/prometheus/metrics2/01HHZ4SEH5S13B9EYV7S4NV4EZ/chunks/=
000001
99586048	/data/main/prometheus/metrics2/01HHZBN68RG5YTA2EP50TRC6T4/chunks/0=
00001


To answer Qu's question from his reply:

No snapshots are involved, and unless Prometheus itself makes recopies,
no such should be involved either.

I do run Thanos sidecar on top of Prometheus, which indeed makes copies
of the files before uploading them to some remote storage, but it also
deletes them afterwards. And looking at the /proc/<thanos>/fd, it
doesn't keep them open as deleted.

No compression should be used (again, unless Prometheus would manually
set chattr +c or so), btrfs RAID. Nothing except a plain btrfs.
I used to have quota's enabled when Qu asked me to last week, but
disabled them afterwards.

I've also attached the output of:
# find /data/main -type f -exec sh -c 'echo "$1"; compsize "$1"' '' {} \; >=
 compsize.log
in case it helps anyone.


The above shows IMO that most data is lost in the chunk files (these
000001 files are the beef of the data).
Looking at the reverse (files where the delta is less than 0.5 MiB):
233472	/data/main/prometheus/metrics2/wal/00000522
155648	/data/main/prometheus/metrics2/wal/00000523
184320	/data/main/prometheus/metrics2/wal/00000524
200704	/data/main/prometheus/metrics2/wal/00000525
126976	/data/main/prometheus/metrics2/wal/00000526
192512	/data/main/prometheus/metrics2/wal/00000527
200704	/data/main/prometheus/metrics2/wal/00000528
139264	/data/main/prometheus/metrics2/wal/00000529
200704	/data/main/prometheus/metrics2/wal/00000530
172032	/data/main/prometheus/metrics2/wal/00000531
57344	/data/main/prometheus/metrics2/wal/00000532
20480	/data/main/prometheus/metrics2/chunks_head/000151
12288	/data/main/prometheus/metrics2/chunks_head/000152
28672	/data/main/prometheus/metrics2/chunks_head/000153
45056	/data/main/prometheus/metrics2/01HHFFHGP4SDPEGGY4ME3GT0Q7/inde
x
229376	/data/main/prometheus/metrics2/01HHFPD50EKCPVC2WZCP006WDV/inde
x
40960	/data/main/prometheus/metrics2/01HHHM6S6JYGAXCQV9XVMGMW83/inde
x
40960	/data/main/prometheus/metrics2/01HHHV2DZYXNFZ5PRHB2M12E7Z/inde
x
40960	/data/main/prometheus/metrics2/01HHJ1Y5QS4DS408MMCH97WC02/inde
x
40960	/data/main/prometheus/metrics2/01HHJ8SXF3W7DKW5N0YACG3ZWT/inde
x
40960	/data/main/prometheus/metrics2/01HHJPHBFVMBRB27ECMNB0J3GG/inde
x
40960	/data/main/prometheus/metrics2/01HHJXD37EPQXB5599MHWEESMZ/inde
x
40960	/data/main/prometheus/metrics2/01HHKB4K6M286JNX0QAX6M5P7C/inde
x
40960	/data/main/prometheus/metrics2/01HHMV6KZS6F476HG6DT4ZM180/inde
x
40960	/data/main/prometheus/metrics2/01HHN22CPP9FVDZG1MGET13J4X/inde
x
40960	/data/main/prometheus/metrics2/01HHN8Y10XMFF9M2CRPQJWG94Y/inde
x
40960	/data/main/prometheus/metrics2/01HHNPNH00AZHAV1RPB6SW8443/inde
x
40960	/data/main/prometheus/metrics2/01HHPZVV0P5QCGG8QA89C36RVW/inde
x
40960	/data/main/prometheus/metrics2/01HHQ6QJRFY0WF1K4QHM74A12S/inde
x
40960	/data/main/prometheus/metrics2/01HHQDKBFRFFQ7J2XJ836CRHW3/inde
x
40960	/data/main/prometheus/metrics2/01HHQMF375KTC4BWMF9RBCM6RS/inde
x
40960	/data/main/prometheus/metrics2/01HHR92618K1C6QCR1JP3NKRR5/inde
x
40960	/data/main/prometheus/metrics2/01HHRFXY8DJPBQ924RJJWZB3BY/inde
x
40960	/data/main/prometheus/metrics2/01HHS4H21ZSZVA10JVDNHNQ7Q8/inde
x
40960	/data/main/prometheus/metrics2/01HHSBCT94CC9AW1N9JQA6VF0K/inde
x
40960	/data/main/prometheus/metrics2/01HHT6VMTVPDT2RMR76P642HZ9/inde
x
40960	/data/main/prometheus/metrics2/01HHTVEYZYPDXDZSGDM91S9QFW/inde
x
40960	/data/main/prometheus/metrics2/01HHVPXVG00GAK4E3YY6ADGDG9/inde
x
40960	/data/main/prometheus/metrics2/01HHWJCRG7WC5NHB684RXCNKMV/inde
x
40960	/data/main/prometheus/metrics2/01HHX048F9110B1CMK300XCE99/inde
x
40960	/data/main/prometheus/metrics2/01HHXDVJJG0YMR3T2ZSS7TMGPA/inde
x
86016	/data/main/prometheus/metrics2/01HHXVK5YTHRVQXEHXWR1K270F/inde
x
40960	/data/main/prometheus/metrics2/01HHYG6AQEAYV7WBSWJSSMHR02/inde
x
4096	/data/main/prometheus/metrics2/01HHZBN68RG5YTA2EP50TRC6T4/inde
x

So the WAL is not that much of a problem.


As for Goffredo's idea about syncing, that doesn't seem to change
things either:
# btrfs filesystem sync /data/main
# compsize btrfs filesystem sync /data/main
Processed 321 files, 793 regular extents (794 refs), 152 inline.
Type       Perc     Disk Usage   Uncompressed Referenced =20
TOTAL      100%       23G          23G          14G      =20
none       100%       23G          23G          14G      =20

And this is anyway running long-term... so I'd assume that sooner or
later btrfs syncs it's stuff?


Cheers,
Chris.

--=-8wc86td02emPTSWeNWXw
Content-Type: application/x-xz; name="compsize.log.xz"
Content-Disposition: attachment; filename="compsize.log.xz"
Content-Transfer-Encoding: base64

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
uuwFAE0rOWuxxGf7AgAAAAAEWVo=


--=-8wc86td02emPTSWeNWXw--

