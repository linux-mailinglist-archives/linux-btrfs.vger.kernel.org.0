Return-Path: <linux-btrfs+bounces-16780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5B2B51EA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51934565100
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515CC2D5406;
	Wed, 10 Sep 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="SIuhCsYN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B1AOKWQ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB45526B777
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524208; cv=none; b=I5LbG+1Yb/LB4E6yjALIcCAJouIcCoUGlFPZdL6158/Q5ZhuxtQVO/8zzBdv9R/9sk/hEoJn5RVkYpe9YGK4Oz1z5z9XakVAWHZTsfMnnpkILhihL/Ib/huN7I5iZlTvAwWHIfDnXaIqa010Zi2nD8+xlCGbQVtUzb3o83Twwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524208; c=relaxed/simple;
	bh=DTAbpSosoj4FeyDT0h2yzYqerCniwJ47C1i2vVWsf54=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MdIinA2dB1Z7XxJeFXbG85PZlmOBGTRvu8MWeaTakrIYnxpivrK/JbqWfzqiYmPK7Ts+C4ajrwyePGJxm9z0u0Wl208IIpNa8dNDMIiVSpDrS6gMrrBQPwJG6OK4E5SLIvuBLLu0ANh1TlvCDVS2QpKjcCczM6bj4vmYyIvkoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=SIuhCsYN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B1AOKWQ2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10B9B7A00CE;
	Wed, 10 Sep 2025 13:10:05 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Wed, 10 Sep 2025 13:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1757524204; x=1757610604; bh=N0yAP3M/lesQTsdmk++h3
	M7W5L8yPgWZK9HHCKX838A=; b=SIuhCsYN0GmS9Xno9rg7t/0l817wAViKxQQnA
	ZuX9OMIKdNDzxTL41+zcwMDAndjb74PcavvlHM4hmZxTn7N9grTV1w+Yi/Kv9Zw0
	4M6JSo/nPJtw05EHISav0QW6G8vBRr+/hdED8xvCQG4+o5zvVplsn3WP5GXZt4bL
	GvDV1jGYlUgcNCvEdryNMLg+2RFW5oxBUxweHpRxi2fWkYglYLmqf4pGaklNdtYo
	bXWuzNog8GLAqeOzlUFnH+1y2htdUMKwWaK9yWcAFXgYmtCKIBlLCvlfl2TW2Rd6
	47sunsMvJS5U/SUjOcflx6cpeq5gTMVmKF8SlSax7qcOuA7+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757524204; x=1757610604; bh=N
	0yAP3M/lesQTsdmk++h3M7W5L8yPgWZK9HHCKX838A=; b=B1AOKWQ2EuWBjvZLq
	Hys5Aj2uQX50si4npM7eodiqJOZnRx9PIqgKoLXgVLwIsYKB3KYy/K80rRptMCpp
	V6Pvni71R8b3xgm4vvU2eVoiTLJYk9FbfFkwzoV4H792ebOoJR6HtCB79eaUqjBD
	T+6Vv3hLca/Z43frowQBimeLC+w/ScPm+SmhWUx4x+T3/7UJbhkn6VSS2r448Tbs
	gwjVIQ38J7Xj17EactHS9T7gk2kxNUZ0JSB5gBDYrrAaXLarWtSkTpm26m0Vhz8p
	I4iCLODnc/JetdxZY0Mb/eY6hzMnvnD7RhC4d3T/VGG5TMit5pEi3oDduZQWShEK
	rfpWg==
X-ME-Sender: <xms:7LDBaLF8Vs-gd-2eFG8_6PyPqTymg8ozrO8U35CyM_BOKJtpsL_eJg>
    <xme:7LDBaIU5_LT4gUyaqopQTXzFyWwwNTGad0M6nYvCAkIvdYOee0PMtpWzaYWZ9UJ1D
    9c6gfpHlZI3YOs8kY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeekieeujeekfffhvedvfeegfefflefflefgjeeiveetveelffeu
    uedvgffhudejhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvshhtrghtihhsthhitg
    hsvghusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7LDBaDJwkN3Gc9gYyo1ZkHRz9o-hz7GYZPwVtovZabniA5465iG43Q>
    <xmx:7LDBaAEvK8-_RlyueyCdgoW3TpH2mxZ50viPSB3m1q8fkR_Tht10jg>
    <xmx:7LDBaNrUIdKEbb-Xr5PW06s5b7rzQYokbrfhhmpqCJjxP_R5QvU_dg>
    <xmx:7LDBaJQvMP5iXW_jO6FYIDfTVaaPjXiJC1srM7SbhQtnXyDaczYpUw>
    <xmx:7LDBaBDvl36hBzAa6hX6SM1-uGg05ggBP8gqiW1lXDcATUInk-iuVd-d>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8BEC918C0067; Wed, 10 Sep 2025 13:10:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvixsGG62GN-
Date: Wed, 10 Sep 2025 13:09:44 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Elias Tsolis" <estatisticseu@gmail.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <3c8f8235-688d-473f-bdf0-f39f19c37118@app.fastmail.com>
In-Reply-To: <c7807695-6e0c-4c97-ba1c-447c6d117a4a@gmail.com>
References: 
 <CAN7+exx=v9mkCGiA5xyrLP8DbCsZb39SDa4XcXx0nxfYtLxa5w@mail.gmail.com>
 <c7807695-6e0c-4c97-ba1c-447c6d117a4a@gmail.com>
Subject: Re: improvements and safety on btrfs repairs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Sep 10, 2025, at 7:04 AM, Elias Tsolis wrote:
> Sorry if you have received multiple emails. Newbie here.
>> Hi Btrfs developers,
>> I=E2=80=99d like to propose a new tool for offline, non-destructive m=
etadata repair.

Is that true? I thought repair uses COW for any tree repair via rebuildi=
ng, and the only overwrite is the final superblock writes committing it,=
 but still with potential for fallback?=20

For sure such COW repair would be limited by free space in existing meta=
data block groups if there's no unallocated space.

Maybe leverage seed/sprout features. The repair mode would treat the blo=
ck device(s) undergoing repair as virtual seeds (read only),  redirectin=
g writes that modify the file system to another block device. Even a zra=
m device.

The user could then mount the repaired block device. Making the changes =
persistent would still require sufficient free space to replicate the ch=
unks back to the seed, to preserve COW.


>>
>> Proposed solution:
>> Extract all metadata (root tree, inode tree, extent tree) to memory or
>> a separate file/image - ONLY THE METADATA.
>> Perform repairs offline, recalculating checksums and rebuilding trees
>> in memory or in the saved separate metadata file.
>> Provide a simulated mount for verification before committing to the
>> actual filesystem.
>> Only after validation, commit the repaired metadata safely to disk.

Something like btrfs-image. And repair that image. Similar to the above,=
 effectively you have separate metadata and data block devices.=20

I guess the main issue is that Btrfs offline repair is complex, takes a =
long time, and has an uncertain outcome. The lack of fixed locations for=
 metadata means far fewer assumptions can be made during repair.

I'm sorta in favor of making the cost of backup, reformat, restore less =
than repair.  Further enhancing btrfs to be more defensive while online =
(e.g. write and read time tree checkers) to fail safely, thereby making =
ro,rescue more reliable.

Nevertheless, there are limits what a file system can do when devices do=
n't consistently preserve write order expectations.

>> appreciated addon - a tool for aggressively reading bad sectors of
>> data in order to restore data.

Pretty much once flash drives are on the death path, they return garbage=
 or zeros.=20

The repair effort has diminishing returns. The reality is folks also nee=
d to backup their important data anyway because there are plenty of scen=
arios that cannot be repaired.

--=20
Chris Murphy

