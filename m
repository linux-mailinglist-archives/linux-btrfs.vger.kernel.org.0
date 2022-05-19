Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7355452D264
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiESMYG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbiESMYE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 08:24:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3A4BA560
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652963043; x=1684499043;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wTPQz5jofEdDGA7zCrP1dQlSb/qKGUaerK+yNUDBSG4=;
  b=BtGRsTka/e5t+HRTdUjWQjXZnyaEOfFmHIzyg7y+FEUQRPg911mxSE6p
   /LG0iXTJxtPt6+uxSQQjznBT4bxY/HpIv1HL1+OWQpKNyPFh80CpSeIwq
   GzUlUT9F9AKfh/Yct+avfQEVE5/U0ykcrfSpX2jxiPFSRsWz+ndSXmkFt
   p3lKf9A9U/adImMlnkNqqP/RaQXYYmyUIMLh0qAdNByaPoXveI72tB1fj
   libchycmxXlMIT8N+zh3rNgA5Eg2DsKmxWjYGjOp93u/FZ+OhjJji1Tef
   exvwYpTO1GIgo/h84o16MuX12iXQ/cuKbokSk0kMPxtFr3psxNV7XB5xw
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647273600"; 
   d="scan'208";a="305009888"
Received: from mail-sn1anam02lp2045.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.45])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 20:24:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBTcnYdOhWVZbn+5HCfImK9Ym0fQMFnxhrHQwEx+9glSC9LkOdjGPdPZ/2hQgI7frjJLfZxS4GiOhRbRAk1FmC56JBrngj9/CNDKMS+22qKEqAcE07YNlDH337g29hQ7z/dMAE6wvTqd7pBSASYfi0RIn1x7bTUzDzW84+kURxVWcII/Nh0xHneRvWFcBMUb4CYA8iWATmigbq7vqWS/A2oaxsidbvTv7Off42Ho7uui5KP2W2OS/Ar0TwlZMeXeRSzOJiKCfcqt8ZK0bnVITgwyMrU3r7meitawEwApnM6rhQfQ0nL9+PeIDY50PgNVGKxofbh3sM3Qjbg50Hr7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNsmK7WmsT+E5bgb9BuZd10rK72nWYIWEAgQ3jzbpoo=;
 b=IuDG6jgR7BEGoqKUi+XY357vD/U0dHgKEq5MufthFJhOSczHzIxtqqogU3tWUcObRAvni5J1m8lpUbyPMuBlcyqPri6n6APFEtDCQnQq28uY3cHpcMBfnwhYxYzum4wJ+T24uGftkFAlnWGQSGUCA+sWwQeiDkFRb4JUjHsD+YnkXxfQo21mI/bAWCvK78vr/Yy7MqGL1jJyWo7zoy7vRkQ8X4bXePZrJp/dTjznkZcboVIU/KeKR0tyzdJ3zdbQVDpZOFU2ZgL2KTz/CL6/CkkiDMeB3UfrzEQiW6KFCfDZBQwDkWeshOsq6LC2EKVYsKIS9FIDyEktji7238/7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNsmK7WmsT+E5bgb9BuZd10rK72nWYIWEAgQ3jzbpoo=;
 b=gZZS73TVp93QZHWZUOL5BOmg22wS1M9LIjzQyQ8XpSZlOWid8uRRl21+d/saqcCCrJ84hQpzF/cuURAqK9LF0GG73oX5Nnpwam450oSMf1mMw4Rg8qiEnP7GYGLxvDIda4ILebr3WFGE+3AiUhV1ccEw3q5eukmmjzcKpz32cZ8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0240.namprd04.prod.outlook.com (2603:10b6:300:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 12:24:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 12:24:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Topic: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Index: AQHX79Oi2SbbVnAj6kGfDNF5QK3rBw==
Date:   Thu, 19 May 2022 12:24:00 +0000
Message-ID: <PH0PR04MB741660777362929B7E3D11DB9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fc2f1a2-fac8-4964-05fd-08da3992744a
x-ms-traffictypediagnostic: MWHPR04MB0240:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0240EBA51B0BFB283D0487569BD09@MWHPR04MB0240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJRvtP7MFlPiN70l3u8+PjavLxS7NHkhVz0cNNUBw1BfsGn3YmL0PApJLfqMk3Y7yAcsOiszdyQv1pubTw1/kfxC3zt2yWhO/b5/XZaEwnmy/mtGZU6vIKUkFXUSnOs1/eK3lgkLJp+IfVNsELyuYhM7T/hUpPWy2O6vM9OWRTUJitWiyW6XwZm2lX6F7nQrfyhYsghnhHJ0XPQfrw/suV8n8krN/8C18rcUx9NXc62Ui6X7uTp/mCtMjWh4alUEkt9xyT9qDeLVb08RxPWzHTKXTNVZEAQQC7zC9ZDiHCchtz8XaHk3yi+e3T6uUA9vel+xM2jxnnYNUq41gH/ap667Ojc6Y4uQywydADJfQAj9Rn3SR0BvDxjLbryr8z1Hirci2KlCjpLHIcSVObE7rbTLezYstYTFaLGbAx0Isxx4iX7zXc5dQblCsWKuxLVzPIxRXZxKHCl6lXtrpvv5OTUhzHepCNbJchxQUhkXFrgwNN+dJWMKr+AtJakZ2cvFe5p25d4CrJdeDNDXfq+Z4dXhJTMKborpNvDoqo2EmNOeS/KJMUrSoEfwGtyb7RMxEL/4HqI0Efc8ObiHtA3N0BJ0eaXpLobBqVkrLLIAlyZokg9VXVxTDIbadsnS3dAPJyu8aw4w7IeEPhu02tmz29vriVItTEpuLyLZpHzX1Y/og7P+/8db3+YrrW1s199/ZFskD0X8QW6NhFlN+wUk444wKQJgp+tAnMDOFAqkTKEQ5+U+pLraAPW4nxSmCuxbN8qvyFFyFwfUenJkIkneuFq5uOKE4axXqOp+8zTFx9M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(9686003)(6506007)(53546011)(33656002)(5660300002)(7696005)(8676002)(122000001)(38100700002)(38070700005)(966005)(54906003)(316002)(110136005)(71200400001)(186003)(86362001)(2906002)(508600001)(64756008)(91956017)(66476007)(66556008)(76116006)(55016003)(66946007)(82960400001)(83380400001)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jf9PzrVpf8s/xAPf9VQaacmKG8x7esjtHmNZ8Gc5Rkz9VxA2nWI3EcOPpi4/?=
 =?us-ascii?Q?bpOCrG5J+BFNYinWCMKI7aovArgBLUXq7nYpgmtEXejO6y6XYtlmxSgOgOog?=
 =?us-ascii?Q?TIM+FAi9fmJ6k/CunnXvVsY5VdAScGQn+giO26kzuAN3ItFih44s2uBeur9j?=
 =?us-ascii?Q?T2CFTze8H1wA1qvCXR1yku4kuh10f5e1rCbLL4ia9U74FHF+Ufk7vIZuENR5?=
 =?us-ascii?Q?5cYxu8KY+inyuqkD4aWJR/1UivSwM3jb/agBP0K1BSmErsc2eBFskiMvKuj0?=
 =?us-ascii?Q?SCBatA/9u4+3MiwjGBdashx6Y+5nX0sHewEbXe6Gc4TkhTLcNC6lkGx67h+8?=
 =?us-ascii?Q?w0yTcByemVzXlwBw0Of8Z7bI5TzEqaIC8GBf/E5P5nQkhj1As+k7uRXWvuwV?=
 =?us-ascii?Q?o6UgsoFQY/R6TeGLEV0w6W2y+ZilYgXBisHYS+pRH5pmEo+Z3ethp8PWiyiG?=
 =?us-ascii?Q?+GZGD7HKttZ8WPh7XFlcLAt+DHghXuyBj77AZ7ggwlZXB9uJZxliI1e7wKde?=
 =?us-ascii?Q?kLCaKjgJxmL2VtB/YkgaxTFOiv3A7H/zMl/9oacT1J5TLbObEgwQnoW/Vo2u?=
 =?us-ascii?Q?Er0+aK5CqzxdePaMU0V7Zpi/QNPBdnM8cveMCMdd6YtTVHj1J0JjzqABKUzQ?=
 =?us-ascii?Q?jTXWThUZTEtuiuTnkHUe4+o6KMRKr+1Ey7+EjpkSzyUelRQ3Oia5EEQ12aTa?=
 =?us-ascii?Q?fKj8jG7SZjmUo7I7T5Uq8hxHmMLZh2DPtDG1/3F9M1RJ1fTpbns9aMIy0X6F?=
 =?us-ascii?Q?0HbKyIKHQ0MMBByzRYsJWeTBD2FTXfeuFA64m/COsY2xPRXnwACl+WakxNji?=
 =?us-ascii?Q?qDqwHnoSutwxWZYahqhJND9JW+8NtV7r6pf2rs3wxWqLp1jiHn8vZGDnJKu5?=
 =?us-ascii?Q?dYKvU9Xi5HiZPkH9KLDkmn81eiahilvbdar813Wbl2nizv4EP1EZxzaS4kMz?=
 =?us-ascii?Q?wTXd8xdqQOLGKWXnvcO19IMxRHi2JJ+9kU/h63Wc2nIVWcOgZCLAd5zC1fAt?=
 =?us-ascii?Q?OoIoWWYi1h302SsaeYeW6LOMUwE43gT6DC6wBSQivoz4RF+N2BhB6iXhQPVP?=
 =?us-ascii?Q?DXWjQ9t2C5jbC3EpC2ADG1aDFke9yw7kodPD4wQbJ0/wo2DSOPIghH1ZaKpF?=
 =?us-ascii?Q?lnGTb+QvaAWjwc/K9XZ1QhaFOz+TXQfryEJjQRgls/Su7/6yQXk5/q0Mz6ZR?=
 =?us-ascii?Q?wlp8S+QYfq174MaSO3iUvwVI+r6exgwldRNCevbTJD1e1NZiXvlLY+ve1kNW?=
 =?us-ascii?Q?ZQ1yA/k1JTQhc4h6qvh/Sb/NLM7ZPCyyGjuMeb4RAhuIxsc1irEl7w3iJLN3?=
 =?us-ascii?Q?D4UxmLN2Qq8kwIiQlicG30P0o1PxURea06lFXfcREhPZwsf8mtbsujiIAWB9?=
 =?us-ascii?Q?0gxQEz6DUQg6/RnhVLJ1qcGg4pAOJHQSFDxYcrjs1R1T1Xz7efGBaFvkGx0C?=
 =?us-ascii?Q?GQITCObbmuBecjV/VQzSQN59yuzX+cf4ksr8klkjEi/JBI3mUdTX3lsvtVkj?=
 =?us-ascii?Q?H7dq/0uXlCPsRsfCyyx1OTWVCZzcogomQXtR7FaaWl3vKYGkv3QxfQ9SWfQi?=
 =?us-ascii?Q?l19g00R+55Mt919o75emSbtDXPltG2s8OUJs/xKSpJ2cHtUkLqA3s9RDCXBh?=
 =?us-ascii?Q?v1k3kepIOARoDvZDuFU5rHNP0ezTMDonl4rpOC/piZgzrTVM4jdTS0NjDo9g?=
 =?us-ascii?Q?Mpz/Xo5lI1zcDpBWslVy/KMlUY4ze5dx8VZGp1kOrlvqTkzpdj6l2dJR4VLd?=
 =?us-ascii?Q?wEXidcjydLF1HVjbnufc/lFm5pEMHEFEOC4z8DuEPtmxFrlIIB6Q815dBH+0?=
x-ms-exchange-antispam-messagedata-1: +VuYBPOxXTW1Enkd+mccti6KIVFGonZpc4GBgicEATQJsfmfdvLpfb/+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc2f1a2-fac8-4964-05fd-08da3992744a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 12:24:00.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7JMLsIVulTKtk5Cbhv3z78PzELAQ6ODycecQ/XtNLckNBVknLnextvakWi+dv9WD6qlbLBHsK6ix+lFN+Blce/Mo5/+TotNrIcO5S8tAhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0240
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

What's the status of this patch? It fixes actual errors =0A=
(hung_tasks) for me.=0A=
=0A=
On 13/12/2021 04:43, Naohiro Aota wrote:=0A=
> There is a hung_task report regarding page lock on zoned btrfs like below=
.=0A=
> =0A=
> https://github.com/naota/linux/issues/59=0A=
> =0A=
> [  726.328648] INFO: task rocksdb:high0:11085 blocked for more than 241 s=
econds.=0A=
> [  726.329839]       Not tainted 5.16.0-rc1+ #1=0A=
> [  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.=0A=
> [  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085 ppid: 1=
1082 flags:0x00000000=0A=
> [  726.331608] Call Trace:=0A=
> [  726.331611]  <TASK>=0A=
> [  726.331614]  __schedule+0x2e5/0x9d0=0A=
> [  726.331622]  schedule+0x58/0xd0=0A=
> [  726.331626]  io_schedule+0x3f/0x70=0A=
> [  726.331629]  __folio_lock+0x125/0x200=0A=
> [  726.331634]  ? find_get_entries+0x1bc/0x240=0A=
> [  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40=0A=
> [  726.331642]  truncate_inode_pages_range+0x5b2/0x770=0A=
> [  726.331649]  truncate_inode_pages_final+0x44/0x50=0A=
> [  726.331653]  btrfs_evict_inode+0x67/0x480=0A=
> [  726.331658]  evict+0xd0/0x180=0A=
> [  726.331661]  iput+0x13f/0x200=0A=
> [  726.331664]  do_unlinkat+0x1c0/0x2b0=0A=
> [  726.331668]  __x64_sys_unlink+0x23/0x30=0A=
> [  726.331670]  do_syscall_64+0x3b/0xc0=0A=
> [  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
> [  726.331677] RIP: 0033:0x7fb9490a171b=0A=
> [  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000057=0A=
> [  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb94=
90a171b=0A=
> [  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 00007fb94=
400d300=0A=
> [  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 000000000=
0000000=0A=
> [  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 00007fb94=
3ffb000=0A=
> [  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 00007fb94=
3ffd260=0A=
> [  726.331693]  </TASK>=0A=
> =0A=
> While we debug the issue, we found running fstests generic/551 on 5GB=0A=
> non-zoned null_blk device in the emulated zoned mode also had a=0A=
> similar hung issue.=0A=
> =0A=
> The hang occurs when cow_file_range() fails in the middle of=0A=
> allocation. cow_file_range() called from do_allocation_zoned() can=0A=
> split the give region ([start, end]) for allocation depending on=0A=
> current block group usages. When btrfs can allocate bytes for one part=0A=
> of the split regions but fails for the other region (e.g. because of=0A=
> -ENOSPC), we return the error leaving the pages in the succeeded regions=
=0A=
> locked. Technically, this occurs only when @unlock =3D=3D 0. Otherwise, w=
e=0A=
> unlock the pages in an allocated region after creating an ordered=0A=
> extent.=0A=
> =0A=
> Theoretically, the same issue can happen on=0A=
> submit_uncompressed_range(). However, I could not make it happen even=0A=
> if I modified the code to go always through=0A=
> submit_uncompressed_range().=0A=
> =0A=
> Considering the callers of cow_file_range(unlock=3D0) won't write out=0A=
> the pages, we can unlock the pages on error exit from=0A=
> cow_file_range(). So, we can ensure all the pages except @locked_page=0A=
> are unlocked on error case.=0A=
> =0A=
> In summary, cow_file_range now behaves like this:=0A=
> =0A=
> - page_started =3D=3D 1 (return value)=0A=
>   - All the pages are unlocked. IO is started.=0A=
> - unlock =3D=3D 0=0A=
>   - All the pages except @locked_page are unlocked in any case=0A=
> - unlock =3D=3D 1=0A=
>   - On success, all the pages are locked for writing out them=0A=
>   - On failure, all the pages except @locked_page are unlocked=0A=
> =0A=
