Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA788781E61
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Aug 2023 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjHTOtm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Aug 2023 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjHTOti (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Aug 2023 10:49:38 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2093.outbound.protection.outlook.com [40.92.99.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA8E6
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Aug 2023 07:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbIiuEmpYdQHD9NSojaxwP6ludJMpUPaj3fYQmKpY9yLN3kEQZm0yWWQ/r5+YhaZONK1mopbTtfUdAjpjEX2ZSTBvB/0hsFOvjlTqscp3FhBYjkK7kzgg4tn96SUO+B/XgzA13CZY1qm4gNuQyg0KozaXKfF2Ap862Y6K+3yE0OJnPKhTL8yasmOU4v7zpW/TdgjqU6HtDMDw9eVlM7M+XTj4zQtFISnHWbjHGGO2MnxMVSc+TjuffXnGhMDSEOqKlnIorhKrdIuhM6uNXgIELvYrrXtvNg+HRKqOoMIua9kkzfMlY/lgpsCuITj8ObRzB+3qpbFfbtat//Dl9OK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hob6BWUrICPYms1PMHHycZNlm/kne9uPJhHmLP5hda8=;
 b=MQUZ8Ie2Wcp/6zrJcAetvPJ4NtbXVn6niymehL1sqgU9gJPkPmdiEMoTWwyZlQ1kmQTJ+c4m/kOSYt033tTfCWFgxkqzezBbKaNREz1qPW/FglLN+nhZpb6kfZhjH8gunlsaQqO8VhAMf2qROSei7a8vg2QK2XnmNT0NYabDncYHgG0VSeyvi1uRs4uvw5q2DuYIrpujeW7RGwub3f/RKmH8z544n5cASdKHghy+hP3e+0r4TruLUyTMZwCMOPsHrkC04wNeyvNsGHtlpx68tdCFx2F0gwFDCEmXJikOOxou5PBLI74TT40SWntcnCDtOp/c49IZBoIBDvjPFTi6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hob6BWUrICPYms1PMHHycZNlm/kne9uPJhHmLP5hda8=;
 b=qErD2svb5L7j32MBDgD+YRsqLjW9Mf8azsa6tJgeTtDcGUwm0uSHjHxuf3bHcAxeMG/RKK5lyP8Y/cwAJGgTEX6MPZXmCIsb26OaSQTq6BZhvMQv0XExDSWtVOn0oqlzroxqb+6I/0tgzuYA01rI7ugqP3HbToCxzB0pKTzQUbRq09+eN/8+etc1W8QfO3IrCIigIMxEMXAJu4mvkgO6sJJ4rZgbEe79pxHWoqHQzQg4R442rW58xObPiPlXvMmocgyiDXSOkXfsbIpLI9m8Qfn8nxRvn2lGSVb7pTWG1tCoqJYeCt9qVyJSojbHBgnj1IlO0AnIyvaIEQYlLqvCzw==
Received: from OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b1::14)
 by OS3P286MB3241.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.11; Sun, 20 Aug
 2023 14:44:48 +0000
Received: from OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM
 ([fe80::282f:25e3:c687:b66d]) by OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM
 ([fe80::282f:25e3:c687:b66d%7]) with mapi id 15.20.6723.010; Sun, 20 Aug 2023
 14:44:48 +0000
Date:   Sun, 20 Aug 2023 14:44:37 +0000
From:   "Longhao.Chen" <Longhao.Chen@outlook.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs check Causes File Corruption
Message-ID: <OSZP286MB1533FD75E8CD5AE3D1CBEF1C9E19A@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=Longhao.Chen@outlook.com; keydata=
 mDMEXzSv8hYJKwYBBAHaRw8BAQdA9uZrGTZwMZK7dZePz0odWlRPdDlVzoiiyF6NLx0tgdm0J0xv
 bmdoYW8uQ2hlbiA8TG9uZ2hhby5DaGVuQG91dGxvb2suY29tPoiJBBMWCgAaBAsJCAcCFQoCFgEC
 GQEFgl/SQawCngECmwMAIQkQkEXN3CzShtYWIQSXPkMjqHHmyexbUK2QRc3cLNKG1hf9AP9iJXyc
 B4V3zTS4KUmXqvLAGrJyCvN79CmaU70TyXiD3QD/cEjVdoQqMUqUmVaBt3mCazvswyVBApub2zuJ
 5TKu5Aa4OARfNK/yEgorBgEEAZdVAQUBAQdANXProV2nVAs7CY91JQnttm5FmICADq7pWuHf5Odb
 CysDAQgHiHgEGBYIACAWIQSXPkMjqHHmyexbUK2QRc3cLNKG1gUCXzSv8gIbDAAKCRCQRc3cLNKG
 1sJdAQDKunoSSuLiOyCWG2bVqnKvOw6PMsbR0E6S19FvbkL/EgEA8Q0lLTfM4tevqeqWmASjzu3v
 ailcQkS63Ori/QVQvgU=
X-TMN:  [H9gcGLZ/ERU4W0/9dQkrU9F91cP0NYgO]
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b1::14)
X-Microsoft-Original-Message-ID: <533ADF24-82AD-4176-BA6E-ACA1A8AD0DF6@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1533:EE_|OS3P286MB3241:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fef127-d3d7-4dbe-5531-08dba18c00db
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiFGXc7lY3AauM+jPffP2wMZUpz1rAoJXhzF8joS44kSzIegaJft4OoO07a3HZR1A3OuYu/+ZkCbOyNUBuMyJgUnvf15zL6slLv36dKIlWEZnXl8TYZWL/8mHkavNV+9+u+kfAv2mfISwz19uuHpOWsHoIEzp5KMAWhgSLo8UOY1O5OO1F3ZauqLXHcZSNAImSavOHDxJ+/qWo99FMpATgkn81Pp6wQY0qNvodjzi8VgaMr80xH8TpG1QFxXpzIGd1IMlj24QPyLEY9JZRo8/n/cXbDA3vckGjcJdWYaeU5cks7con2N9ZU6lnb0QkylQMFC4ayVciz/6uFX5OBJpniR3qtUZZBIbF9iKBzePUQ+5JgsmsPeRkAXl7XaEyzOZ58CO7dCAB265P74c/H5azo+IXojFDKIIaH+YnOM36Mg3jnLvr5TFtD55DmuPh98AFmWfgMgX10imDP6gIgVRK4wAMX/PfFSZ/vuyJ/Wu1JANuf0ezvY6reOgUC4uW5yQmUqopWjqLqep2HP/HJL46FVCkrSF9jmNLFSqnYSeiVMDZ73tDCyM6R4nxCzW+s/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGZJbkptRmJEZDRsUTltUnNYZVN4MTBkaS9vZXUybmgwY3ZsMTRLOXg1L2FS?=
 =?utf-8?B?QWg3NEFSQ0RYU1FJOVkxcmZEeEhZK08xQXhkam11VWpySmplS2p1ejJxK3cy?=
 =?utf-8?B?akNyUWRES3dGaGFnaFNsRVVCd0dUdk93TmNoalhtYTNiSTN4UFRPZlVWeEVR?=
 =?utf-8?B?WTRzaldJS0VuSjRWOE9DN0luc0NhSk81K1ZSUEE4eHdRaU1raHJmSGQvcEgz?=
 =?utf-8?B?d0F2b2pYSHdEbm03MC9Cang4SHB6YlBML2JseUdxaWNtcTJGYVZRS3hHaHow?=
 =?utf-8?B?YS9aQ0RTR2I0WndBSDdsK3FhTWkvUFVtQmZLVFlMNHRTVkE0dDFtNXphZk1G?=
 =?utf-8?B?SHpRSXljMFg4ckEwWlFzWTUrS2Vjam5USWNYUGI5Zi9xSzJpb1NVS2tQa1Mw?=
 =?utf-8?B?U01rdnh5aHdVLzVwTXdqbWREMkdWaDQ4RUVLYnZ3WmFmT243TXdCOG03L0Na?=
 =?utf-8?B?SHEyYnA3V2dnVmorR08wcSs2NmJ5TFhpSjZCeUhmM1YxTTA4VnpzaWJnajBB?=
 =?utf-8?B?cDNlRFo5S0pFUmdDR3VvOEI4QW1tQVQ2cmNacVJyNGNvRlJsdmpqcy9ERkM0?=
 =?utf-8?B?NzBMQ2hkSVlnQjdtaEhmMXhNWHZKY3UxTDBsbmJ6UEQraUVsNTRGelk5WTla?=
 =?utf-8?B?UXg4NkU5ekVTZTlBWnlKdGFQNDVDb2RiMHRuVXJ5eXovRkliSUNhcDlOZ1FZ?=
 =?utf-8?B?UnIrNHZzaHYreDl1ZWlGQ1lkU21RT3hLc3JyRFJGTVl2WkRqeHNlbTdFbXI5?=
 =?utf-8?B?QWdqakI4NzV5V1NyMmIzaXNuZ2JYZ3hyaFl6V2NRZ2hjQjJJVGllc0E5ZDhM?=
 =?utf-8?B?U3NiN0YvQzhndGg2a3pINEs3WGd3cDNyL3djMTkrSy9YT2gxZmhiSEM2Zi9C?=
 =?utf-8?B?MGVBNGJDczEzbHlzQW5XcWpaN203ejRFSzVUbUR1ZnA5SVZyR2Z4OHoxZC9y?=
 =?utf-8?B?WFRoajdOaC9TQWVvOUFiMUx0VG9IeElscVNkTFh6ajJDbklNR2N6RW9odG1x?=
 =?utf-8?B?TGprcHZnemxHeFdKcEJqR2ozU1R4bnRJVmZKWFBYekNTMGJrcUhXVmZjZXdW?=
 =?utf-8?B?VjZCWVVIcGlPeG0reVZXTGF2bDRXbnNuZVdsaHJmb1BxODZKaDlicURVT2lu?=
 =?utf-8?B?Yk4xZXVqaVJqTkd3N1dUTXJSODY4b01kQlpmdTVqRER4Z3c2MXN2UjNqem1I?=
 =?utf-8?B?bHdwNVFkY3ZrdHdyalNLT0pwSWZxUkN2cHAvelRwUFJnaFF1QkZ1OTF6UDhP?=
 =?utf-8?B?NkQrd1VZRWliWHFsOWdOcWdXMFdyTnFYVFVkSm9xVGdIK0NVeFBKb2RTdWx4?=
 =?utf-8?B?elhUcDBQY2w5MFQ4Y3orVUllQWFYRnB2TnJhZjJNRWNNZW1iUW00TXhWOWpi?=
 =?utf-8?B?K3h1Z2FXRFdGZXQxRTFiL2dxdzZNdnBmZlRJdDN5M2hxYmhRR3JlQWtxR203?=
 =?utf-8?B?STk5SW5HRHVWN1dJaXFXS0tKYUhValpVUVRtNWNHM2gwVWtSMURTSGVvZ3V6?=
 =?utf-8?B?V2QySVYrZFdvODI1eVJSY2tCRUIyNmxPejZ5RE4yRWNDY1dONU16Q0cxZ0lW?=
 =?utf-8?B?QXQ0aW1HRitOdXZBTHJKbVFFQVpYQ2psdGhDUEkvODdKdUdkOCtlb0wrYVB4?=
 =?utf-8?Q?Aqy9xi7xlQzJlXCIzJ0p8GJKPCRCiQy0nLh8aL6Ywg2A=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fef127-d3d7-4dbe-5531-08dba18c00db
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 14:44:48.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone, I use Btrfs as the file system on my laptop. Yesterday, I w=
as preparing to backup a snapshot to an external hard drive using btrfs sen=
d, and the following error occurred:

ERROR: send ioctl failed with -5: Input/Output error

I used btrfs scrub to scan the disk, and the result was:

Error summary:    csum=3D1

Corrected:      0

Uncorrectable:  1

Unverified:     0

The disk is a 1TB Samsung SSD with less than 4TiB written, the SMART is com=
pletely normal with no errors. I suspect that this error may have been caus=
ed by random bit flipping in the memory (DDR4 non-ECC memory).

Afterwards, I booted a LiveCD and ran:

btrfs check --init-csum-tree

During the running process, many outputs similar to this appeared:

root 1380 inode 5006723 errors 2001, no inode item, link count wrong unreso=
lved ref dir 1164151 index 1566 namelen 28 name <filename> filetype 1 error=
s 4, no inode ref

Then I found that the file in the above <filename> had disappeared. At this=
 point, I immediately backed up all the existing files and then used:

btrfs check --repair

btrfs rescue

in an attempt to recover the lost files, but was unsuccessful.

The current issues are:

How do I recover the lost files?

Why does btrfs check --init-csum-tree cause file loss? Is this a bug?

LiveCD information:

Linux ubuntu 6.2.0-26-generic #26~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Ju=
l 13 16:27:29 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

Thank you for your help.
