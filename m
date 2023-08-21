Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B39A78214E
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 04:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjHUCJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Aug 2023 22:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHUCJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Aug 2023 22:09:12 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2064.outbound.protection.outlook.com [40.92.98.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8CE9C
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Aug 2023 19:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUNu+1yOXwZI7Re84hSnXhNFlRuwqgbrSYPAa/uJZaNxr6GcTNJ8+rYdlcqMIWo1U3t/hq3CojE8tEAtkvymtr5fe46+9LML/39IvwoiWsw3dIh/peh7m2RbbYc2JEf+Ek7sHuLmSvKjmLB8wceATF+Hb67W5Mh1u1p5+5ruuD2/1cUw7gv9sEuMAlp6/pIIfr2JRzDnQ9ejpdsaCD8zfUPWbXUwkGfNagbWc3TYJc1uFCFAz8s8SRDJs3jhiOA+40lQS6EoJcvHQ7eu6qwI9ea1YsfBx5gH2Aoa6V1h8UAzk/RSj3AN26BwzbTyDyzOytK+C3CuiMgTv9ebAVhcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp3P6vqgP21dY+JuB56VQnAmqwg8I+lraOxdSAmKmEY=;
 b=Xz25dJxaAadCTbQOvdX3co9jNJUPZPuyUOQeZI0nSfEApDkhITIj8fsPmB+wL9EHq6W4lHbnzx19HyFrUycsBc6l9/OCS8SK9IiP5ngDmofMNLhFTQGccZ9D/6gDGhekqeTJrzx+3yCA32TGkZfSBnkPrs7zixZ6BPlVXJiUpNxXT6QxeJZFWQGna4XXMEg4mGmXmWc9zr1y6BByVSEglgp/kutF8wscwRtb749CSPnf2nx14PLuHfFzhQbOmlGaNDbCVuXA8/SCeS8QtVM+lc5bXtmcj/B09191spSbykTesG1WfwQCu2y6z4NXaWe3UhAk/q/tcKixOiRod3H+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp3P6vqgP21dY+JuB56VQnAmqwg8I+lraOxdSAmKmEY=;
 b=MbsceIlRO/faTTqi1bDULfm5nTlt8dDlUvtZspHwnC4p7fSZfaeUVSA+BcWXgeeD5VgqhBsAthW2SjURlcc2OuFe8xUr21gTrw3iXfk+MrccOMNrdXcdeCiMSMy15PC+SSBzTVLrXPplY6L93m/uYGcdx7YOovDaR0ryBrVP+CIWAddfJz3wNwlpgNds8bE16PCuKG/ijv625MKyvRhmoSN5+GTq55rY3NeOTmTtWuNqJQ5QjQ41AVcDrvQITbuI1eqmo4G/rCeXTik1QNJTV4RWo10tnK5xb4Bd3FPEhSLooPplONi/fVf9zvTqQwlQYi50hx2ETwFMSw6SfEK/tw==
Received: from OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b1::14)
 by OSZP286MB1488.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.11; Mon, 21 Aug
 2023 02:09:05 +0000
Received: from OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM
 ([fe80::282f:25e3:c687:b66d]) by OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM
 ([fe80::282f:25e3:c687:b66d%7]) with mapi id 15.20.6723.013; Mon, 21 Aug 2023
 02:09:05 +0000
Date:   Mon, 21 Aug 2023 02:07:54 +0000
From:   "Longhao.Chen" <Longhao.Chen@outlook.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs check Causes File Corruption
In-Reply-To: <b3fce2d5-c589-4356-80a5-4d973b63ae28@gmx.com>
References: <OSZP286MB1533FD75E8CD5AE3D1CBEF1C9E19A@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM> <b3fce2d5-c589-4356-80a5-4d973b63ae28@gmx.com>
Message-ID: <OSZP286MB15336127387272CC9919EDDD9E1EA@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
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
X-TMN:  [8ID8PBzCCuth/UbqJ6iC+k7dwtHynkov]
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b1::14)
X-Microsoft-Original-Message-ID: <EB917942-A75D-44A0-95A6-4222933F494D@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1533:EE_|OSZP286MB1488:EE_
X-MS-Office365-Filtering-Correlation-Id: c94179b1-38b5-4779-3a85-08dba1eb9865
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYqL+fTl64k0YjgC+YsNur8wX12i8H4lCSj9o2mQZQIrJFE1RYRPqrUgjV9BX4mlHVJ0qaSgPDr+9yLlpAGgiPR7HvqX5JH6Ytn5YEfwBoGX3mO3Pp3ZTnkYvhkWfdD9TanQaMcBiU3Mhi09uwCH6Bi9SPDA7TsNWxrlP1yel3iSiGbfox5wvJ2thvCzBwvOZum55yg4dDIZhksukRpMzw3x+tzTSZP73Kxcbo7zMRy4ZISosmT+q//KWmjbp3xw29sCwDSVjrKUt6SIKrLNAg8TJ10M7WUhP97xX6+pT+9dDYatvfRw9tXlVuhMpj6rd3GTH9Ttfz+rmUQnMWo6+2w1458xGVLuzL33foQzxZLb7jTI/8Op59/8jCH07j8njCDLFilu8nKN6dwSGZb11sW82/UWSqSIFW3CN1CeahqE3R+SmAIW/Td0qRrkyaABkC+ARyQAJczjXK3EUAVd1Qo/YA2vpc6zjRYdpPCLUjODSNdbKP/Mzc/3bK6YSYAMbEy7qRKRisyK2mtcabS1OX8/Cw19ck7FLfeDz3Ote0/4EvLtoZXRZpQ3jayWR3jr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlBeENsaUk4R3NzM3RQTnVRMUZ4UDZyV0pTZFZwbklSbzF6NCtERm5kVnRT?=
 =?utf-8?B?M3llRG1ScG04d2xLYmk5KzZqUXkyK3gzaC9zTjNEN3V3WHhvNWJaYTRXbnov?=
 =?utf-8?B?eFptNUZvQXR3SllFdk5wZXc3cUR5Ly9JUDg3cGVJeFNtTS9QL1pyMVRWNUJu?=
 =?utf-8?B?aVJxNWMyVHdwc1Vrejh4RXNObWZiMGM1R0tNOHJaNWFQUk4wa0U3RGtnL05w?=
 =?utf-8?B?MWJnUldEbzZKclhHSEtBRUwzNzBrSjRPZ3h6WW5FVWt4WGZhSmdmbEdtT0Zw?=
 =?utf-8?B?dFE1Z2VZL09ZV2w5bWxYOGhpN1FXZGZDSmwrSWR6MDBBVGIzSUliSDg1Mk0x?=
 =?utf-8?B?dmgweGhIemhyMGVLVFJ0eElCMndpVGxQY21Wa3VrNS9jdDRaWnNneEJPelJE?=
 =?utf-8?B?T0FoRkdpZ1kxTEc0a2lxT3BESXVJOVl2cFA4NHV1TTc3THgwUDFEY04yQmI0?=
 =?utf-8?B?K2R1Mm0yMTZmTElRUnMwL3RqWTZQb3k1TzZZWnVLbytsQ3dZZVZSeElxUkJu?=
 =?utf-8?B?S0Q1bUJ4TTJOL2JBTDg4WkY4TlMrMDI2VDh3QzllZ2I3UEoydWtqOGhPMlhO?=
 =?utf-8?B?WE5MTVIyUHNCcm81S2lHUVpBUzg0UkdFSVRtOXo5R3g3NnZHZnZDUWlvUTAw?=
 =?utf-8?B?SDBkSTFyWS9WcTZiVm42Ty9lcXc3VW83bEtPMFBiV0h6SnQwSjUzOVVzN3lR?=
 =?utf-8?B?YytQVHlYQzZaQ2YrQUc1MzI5ZU9OWDRtSzVRdTRDd0YzU2cwd0Y5ZW8yWDBI?=
 =?utf-8?B?b3Zub1VNRkhPVFZVSkptZnlEUlluUUdSaEczYkcwS1RCY2tyd2h0cVVhMlBE?=
 =?utf-8?B?RjM2OFBmalp4NXo1OFNETlJiZjdzU0NJcVhNdk5uNGlCVG1zV2w2SHZqL3R4?=
 =?utf-8?B?L3gyemhLYnp5bnVieERzUjRKWlV5dFc5em5MeFdnK0djTkdVdnlGZFBXdGRi?=
 =?utf-8?B?dENHRlZQOEVtNlR3dlZ5bWlZWXJkZnp5YXFiR2EvS09YR2xsaXI5NDM5ZFJO?=
 =?utf-8?B?dGdZczdrVGNMbzl6THZWS1RhOHBUK3kvNW1sUnRSYmhGWm5TbXZYSGpGV3p5?=
 =?utf-8?B?Z3RJWHFPTE9QM3FMUC9FY0h4aW1aRkQzY2F3R1E5RWI0OWZHamtGMXJtZ1ZP?=
 =?utf-8?B?eWxNcXdzNVNzUEUvWjJ4dnNmdDkxRmZsRUNxMGtOWmY5akphNFB0aHQ3cEVH?=
 =?utf-8?B?M2xnTXFZS1NvRkVUbGxKNWhPZ2lRYUpDbUVpR2ZZT2VZSTNYRStTR3NiWEd3?=
 =?utf-8?B?V21rYzZiUHV5Mk9zSm51TDlGWlcxVm5CbG1CVkhObjNDcjNWcitCNWxYSmZz?=
 =?utf-8?B?c3hrZ1l0SjlkZGdLTDM5RGRZTXVhbnlFcjBYSDZtWWdFbDhROUhyQ1YrQ3Rl?=
 =?utf-8?B?a0hMU2l3bzJqRzgvSkkrR012dTVObHdPbm8ySEZZMUM2U0t1T1M3M1FxQjFk?=
 =?utf-8?B?VVlsK2lucU55YS9GdlhCUXU4SHZRZWt4dU0wZExkSHU2cGUxR2dNUXRTcmNx?=
 =?utf-8?B?K3dFcVd0T0JzU1dNK1VCK2JHanRabUxMa0dLVm83NDRtNHhRQTFjQ0Jvbm1G?=
 =?utf-8?B?eU9icFFNNnNRUS9jMGJnWUhsLzBPWCtFT3VGQ3ZzY3NXYkppTmg4Z2huNmQy?=
 =?utf-8?Q?e3Xk2LNi7TpFhOVmZwjglyrQ4VeM/rXcE8Shv8/WzUOk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94179b1-38b5-4779-3a85-08dba1eb9865
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 02:09:05.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1488
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for your reply.

>Without your initial btrfs check --readonly result, it's really hard to
>tell what's going wrong.
Before the repair, I ran the commands
btrfs check --readonly
and
btrfs check --check-data-csum

The former did not return any errors, and the latter reported an error simi=
lar to this:
mirror 1 bytenr 13688832 csum 40 expected csum 198
ERROR: errors found in csum tree

>Csum error itself can be caused by incorrectly utilized direct IO.
>E.g. modifying the direct io buffer while it's still under writeback, in
>that case btrfs just properly detects such situation.
After running scrub, I found out from dmesg that the file with the error wa=
s a virtual machine's disk image, but that virtual machine was not running =
at the time.
