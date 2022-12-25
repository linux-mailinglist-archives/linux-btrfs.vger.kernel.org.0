Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C290655D2B
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Dec 2022 13:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLYMLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 07:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYMLO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 07:11:14 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1601127;
        Sun, 25 Dec 2022 04:11:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnLRJ2NBLETpxEYSJGTZiDWFI7YjlM5WHEaGh5+sn1oJMzNh2owJ+z+3w445C5fBecEUbKdpo0weTP42gkkxqw1ERxj6sB0jYH0mcRGLK5752jh0XxtC/Ft1x2vwhEAxUc4fEPUb7Q4uB6T1JeEfJ6YWBftdHm8YdXkVLD1XwPmDc9YJKOBu2kSqprEIDOicLWIMe6Bbb2hJPTqF235OEPsDTj0ekriXYvB/+WqZ38p4spNYLbWUWLlcCXjfRokKk2KJTRZXxUdN+E6bXPhXr0P9OBAFVwRSbQGS9X06fENwWJh31E9BrXYRRW6GCEG6unkn+mqwvGQ2IMMEGTrqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h38BAZRUZlsT/aYAOmjo26aS5FZKDQJkT4QrKGot5r8=;
 b=YXk91dMN8UDQObBgZN7rWPJtZckVgdxt4Aj5+LqLDzhzIy58hSdzaLF6hfrwT7JaR9harB8oweVeo0rf+BmqNsFLPCGH0iuvuHjTSXHvzXXkEeFgRtf9oVd5Bj8iGpbrI3HbQQ8FeKED//jA2rGTIY+AOtOwQW8hi6PeXbAWq/3NNxZBi+H4+bFqsv3MHaRfyV4lsd6r8JamwO5zZcie7WryenYzIhJ88YzSAxqBwGn3pahzPO7zO2B9lyAgrGP5GJWGLD+vKxxvh8o5tlZ3lP+AXwosybuS/cJ5xYYWn95bZ4MdHd5jxxWGKYBqC8XyvVTjVYMnQRibFF1fm2UtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h38BAZRUZlsT/aYAOmjo26aS5FZKDQJkT4QrKGot5r8=;
 b=PuCajK3VJBafKFflKDoRE2zawj1hU7E2wU/Mfncb8h1NBfmtp2M83vJAi0ZUsubp/n83Rqsh02YW9qTWKYAFfDpfhmmLM/USBgy6cOpWoHy5nzT6YnFhUltW9urkJ1wrFqtdo9uyCXWVCvdVFvjMl8C9Fdvqen3ExYQdx+DTOv2GDrewOZrUQHXnZRM31/okL8dNAqkP2J6lhGMIa3pcyuWHEyrineSMJULjR/q7OFcuv43s0Zg0SZv5LbEMfsttarw1twMcIrgNQuxnAH7j7jPHYVh3AjeSRL673PwcdhXNOChyS1GSuJ9wqaqRiD1H/GuoR+hxub5NXjcCJfy1EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Sun, 25 Dec
 2022 12:11:10 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%8]) with mapi id 15.20.5944.016; Sun, 25 Dec 2022
 12:11:10 +0000
Message-ID: <8f58bb60-edb7-5bb8-ac6e-01df06593d95@suse.com>
Date:   Sun, 25 Dec 2022 20:11:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20221223025642.33496-1-wqu@suse.com>
 <20221225115146.t2y4adfguq2qtg74@zlang-mailbox>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs/154: migrate to python3
In-Reply-To: <20221225115146.t2y4adfguq2qtg74@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM8PR04MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbaaab8-3a52-45fb-1da1-08dae6711bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXsISYcfPN4pYjI4xNDzWggsRZbZl8kvK2LSAnLcIS8JeBiPnDN8NLXQNO6rkyaIGI7MXyS+KfeoEVmzn4vyOHPiYXBXwfKB0W4omzkYCNOM/Jx/A4hW9IWhsfkHZ97R5r9IHbUeCEE2293WvGTjTZrft3wtfRUK8C6etCZ+i0oj8Q+999E+d6/dZR3H+Czet6mtFTlzbla5vk4wL8fJUmRf7H23FKxJ8dYweSIhKiwDOAAGBwcL+NgHgA+4HlDgwxRlOSWt4pH480d817TS+Qf9LHnjqKGakdQRsZl+NF7629XA3YNfIyOiv+8GMqcR58rFvKiwADzdwS8PwJMI9qqzrm4pEMP0oD/WiS1amoYBrVeOfqGU7EJOP3uQaHcJneKc294M2kcb0KQFe6p8X9ib+U2YmQPfFDc+FD3Q+BiRFWPCUXExn5+dMEDpfxsu1xwdDHCNIYd81d5VmiTyZxwG/jiGiVmZN/aCh8gixdz5ZO27TYGT1UE7YVX7i6/PEksiM7RhsuSoG08YKYFDjV1otE8rutPfLsFrr6OaWotvX/F/sU0AnuyN5fwIkh/sKEfuSdeFtmzEHu77wCJCRtH2GFgJhyVaB2RZNCB4zGGPyfbEcgtZmsmRMbq7FDiHTDTGdkdlOEYzqzbxP0m+UDTFEUWUB0jAHDYwMbJhnQcZmkc8Ci7JT71Oyy6q+Wq0vRiYG/kRrm0sSCTtCUzEIKwZcUeNXCBlwBV0ldAuw3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(478600001)(6486002)(6666004)(2906002)(6916009)(316002)(36756003)(53546011)(83380400001)(38100700002)(2616005)(186003)(6506007)(6512007)(31696002)(86362001)(8936002)(8676002)(66476007)(5660300002)(66556008)(66946007)(4326008)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N01HU09LMUZtVWJKdWpzbXhRRmFRcjQvblA3TGp0cW52YjN6MUZYVVoyZGlr?=
 =?utf-8?B?ellOSWE1MG9mNDkwTmNqWTFXWDl3Q2NaVkFHMFp2TGliMFJFOWludWhqN3dU?=
 =?utf-8?B?WERMTE1FamZXYXJmajh3U0QySGJrWVJzTmp0bGMxZXJwODhIZEN5REdoR2pS?=
 =?utf-8?B?WlVFbXJMT1hyV0ZCd25wMStLOElpVjAvd3N2UjdkL0ZCQlB5bFc1NUIxcmk3?=
 =?utf-8?B?dEZWSGhtbmM1OHZNV0h2RGd4QW5xR1MvK1VBNTVSazA3bFlJVFhHN1hKYnRt?=
 =?utf-8?B?dXBuYkxZVHQwRXhVd2IxNnhxaFdObUxpU2JZSnYwSDl3VW9VamVMNkFoNUhn?=
 =?utf-8?B?UFg2UTJ4TWxjbWR6UzduT29NOHNXRXZCYi9NdnhqUzZ3ZVJ3N1FQTFo2S3or?=
 =?utf-8?B?T0JYWmxublZ5Tms1YmtPMnJtcHpRNjlVUHNmdFRXeXZMSUxCNEh4RzBtMlJs?=
 =?utf-8?B?bzdPSGNXdTR5aFovSFdWb1JQWXFvTzFWTlVtNXljNDZoemVYSUtsWjVkd2RV?=
 =?utf-8?B?NU54VmI0N3dnN3U3QkJqQ0J5WnBsanR1WFBKOFRRQzVGdFFYdENoVWhMMGRO?=
 =?utf-8?B?QWkxQWZ3NmZZRndZNEZiaHV1c3FyNENPWlZJVEM5K1NUMG45K2pMWXZUWWlF?=
 =?utf-8?B?YkwzNjZMM0psS0h2Z0U0bkQrTVR2WkhGVFowTmdlOFpZMCt2amhSU0QwbEFI?=
 =?utf-8?B?ajNCRlJQd0NEWi9EZHJFcG9ZMGc3VFFyVGROUlJmeVVOamp3V0E0aUNpR25n?=
 =?utf-8?B?Mmo0UGRHVWgvMVRUMnl0V0tNaHdYRi9YVzZRVFRXdWFFZzc4QzkySk5lVmwy?=
 =?utf-8?B?bll2SytXZjVBcVJ2NWFvaVdhQ1pZUGlXYThWVVhKQlZRUS9lSFhRUGZKREJh?=
 =?utf-8?B?WnNWR1h4VGRybmEwbWx3MXdpZjJSaFIyUnY0M0RqcVZzdUdVM1RrYVg0VHNC?=
 =?utf-8?B?aS9xTDlNM1JyTW85ektSTzRscWdlcUZFdCtkUHdQTlQ0YUhYQ1laTFA4UVV2?=
 =?utf-8?B?dGQrSE1weFA2WFF6bEF6Yk5VdUVzTzgzbmJHL09ZNEJEd1lOQ0tZQnlyNWtt?=
 =?utf-8?B?OUI1d291eWRJZUNUOENzcVpZT3hZN1YxUmkzZXIrQXk5ZjUwVC8wbFhyU3JO?=
 =?utf-8?B?ZTdtdVpDVzE0UG1KQU53dkZwd2RqdS81TzZncmU0MTVvaDU1dUYwUXlWcVZL?=
 =?utf-8?B?R3F3MlQzTDh0YkNxbHF1cTJIc1V5djZTNjJlVC9hQkw4Mm9GSXRNYWdNb1F6?=
 =?utf-8?B?UkxJWGhvVWorTVE2S3l6MUNrSFJnN1RJb25WTnJ4STBKNzJXWW1uMjZudGFE?=
 =?utf-8?B?VjFnWTZDMStFSld4dDdXOVFkaUsrYnZ0M3lsUUpUdFhMQ2hxTWFvQTNUaVVk?=
 =?utf-8?B?NzRCdExDbXByem9wK084MVVrVnh0VzU0RWd4UkQ2TCtvLzdmaUdZVXdYcUxK?=
 =?utf-8?B?TFZvOE9LNHVFbHFldW5mL3BWQVhHdytaTUt5OUhvU1lCc3FCT3ZOWGFUdVB1?=
 =?utf-8?B?MXlFekJHajVkbUNkUklSUHp4UDYza3JGdkhxYXZtS2twYlJGL3dRUzY4ejNr?=
 =?utf-8?B?NzliQWpGdDF1Ykd3Q21RTWFYZThwSkNsMnE5aHoxV0NrL2Nkb1ZuUW1EY0tM?=
 =?utf-8?B?WHRQbVJOMkg4a3dNRno3c2JBWXEvcWZTMnE4Vm40KzI0TGYwTXdNdkxzVVdw?=
 =?utf-8?B?SDB4MlFnbFh1Q2RVMk1NeW0zVWxuaEEwTnRDS2RWSTdyQTN4bVR2UjdZL2xq?=
 =?utf-8?B?ZDVuVUNBTDVHQ3JTZlB1cm50c3h6a3QvcFR0N0RFOGRsTnpqQkV5YUl1UnV3?=
 =?utf-8?B?UmFzMldJNkE5TGc3RXh1T0ZqRTlCNXNmejA5aFNqWUp2YjRnYStMdG5tM2NK?=
 =?utf-8?B?S2hpcVI2YmEyZnh1ZmhjWnQzYm5BeG1vclVpMmlSTm5jUG9LbW1QNDcxcGhL?=
 =?utf-8?B?bUg0VC9IR1B6T1lqLzY0Z3Z4U2lGTnJocXkxMXpSVUwrM0FWVWQ5SmhsSTdy?=
 =?utf-8?B?djlJeGdKSFBkL0xZa3N2Lzl0V3doM04ycjNZT0dBbUw0MG5oMHZWSUloV29y?=
 =?utf-8?B?K256cWpiM21Zdm1BVVEzejUrbDVKeFI0anZYSGpGWC9KWlF3N3RuY2RBR3NV?=
 =?utf-8?B?eEpmVzE2QlUvUFp4dXg2d2x4L0NONUp5UnFGb29DQWpFSmxHZk9nZGt4bU1J?=
 =?utf-8?Q?ltzwpYcsGHiel1d0qpU0TWM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbaaab8-3a52-45fb-1da1-08dae6711bd8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 12:11:10.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/Cr0Kp6bPdBnfqWLVbdAweNgr0qYlLSHSrMu2rGctCUyTZ0OzlywDS3OsGfrjH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/25 19:51, Zorro Lang wrote:
> On Fri, Dec 23, 2022 at 10:56:42AM +0800, Qu Wenruo wrote:
>> Test case btrfs/154 is still using python2 script, which is already EOL.
>> Some rolling distros like Archlinux is no longer providing python2
>> package anymore.
>>
>> This means btrfs/154 will be harder and harder to run.
>>
>> To fix the problem, migreate the python script to python3, this involves
>> the following changes:
>>
>> - Change common/config to use python3
>> - Strong type conversion between string and bytes
>>    This means, anything involved in the forged bytes has to be bytes.
>>
>>    And there is no safe way to convert forged bytes into string, unlike
>>    python2.
>>    I guess that's why the author went python2 in the first place.
>>
>>    Thankfully os.rename() still accepts forged bytes.
>>
>> - Use bytes specific checks for invalid chars.
>>
>> The updated script can still cause the needed conflicts, can be verified
>> through "btrfs ins dump-tree" command.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/config                   |  2 +-
>>   src/btrfs_crc32c_forged_name.py | 22 ++++++++++++++++------
>>   tests/btrfs/154                 |  4 ++--
>>   3 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/common/config b/common/config
>> index b2802e5e..e2aba5a9 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -212,7 +212,7 @@ export NFS4_SETFACL_PROG="$(type -P nfs4_setfacl)"
>>   export NFS4_GETFACL_PROG="$(type -P nfs4_getfacl)"
>>   export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
>>   export THIN_CHECK_PROG="$(type -P thin_check)"
>> -export PYTHON2_PROG="$(type -P python2)"
>> +export PYTHON3_PROG="$(type -P python3)"
> 
> How about:
> 
> export PYTHON_PROG="$(type -P python)"
> export PYTHON2_PROG="$(type -P python2)"
> export PYTHON3_PROG="$(type -P python3)"
> 
> maybe someone still need python2, or maybe someone doesn't care the version.

Even for distros which completely get rid of python2 and make python3 
default, there is still python3.
And python is just a softlink to python3, which further links to the 
real python

  $ type -P python2
  $ type -P python3
  /usr/bin/python3
  $ type -P python
  /usr/bin/python

  $ ls -alh /usr/bin/python
  lrwxrwxrwx 1 root root 7 Nov  1 22:18 /usr/bin/python -> python3
  $ ls -alh /usr/bin/python3
  lrwxrwxrwx 1 root root 10 Nov  1 22:18 /usr/bin/python3 -> python3.10

Secondly, for this particular case, we must distinguish python2 and 
python3, especially due to the strong requirement for string encoding.


So to your PYTHON_PROG usage, no, it's not good at all, it's going to be 
distro dependent and will be a disaster if some one is using PYTHON_PROG.

For PYTHON2_PROG, there is no usage of it any more, thus I see now 
reason to define it.

Thanks,
Qu
> 
> Thanks,
> Zorro
> 
>>   export SQLITE3_PROG="$(type -P sqlite3)"
>>   export TIMEOUT_PROG="$(type -P timeout)"
>>   export SETCAP_PROG="$(type -P setcap)"
>> diff --git a/src/btrfs_crc32c_forged_name.py b/src/btrfs_crc32c_forged_name.py
>> index 6c08fcb7..d29bbb70 100755
>> --- a/src/btrfs_crc32c_forged_name.py
>> +++ b/src/btrfs_crc32c_forged_name.py
>> @@ -59,9 +59,10 @@ class CRC32(object):
>>       # deduce the 4 bytes we need to insert
>>       for c in struct.pack('<L',fwd_crc)[::-1]:
>>         bkd_crc = ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >> 24]
>> -      bkd_crc ^= ord(c)
>> +      bkd_crc ^= c
>>   
>> -    res = s[:pos] + struct.pack('<L', bkd_crc) + s[pos:]
>> +    res = bytes(s[:pos], 'ascii') + struct.pack('<L', bkd_crc) + \
>> +          bytes(s[pos:], 'ascii')
>>       return res
>>   
>>     def parse_args(self):
>> @@ -72,6 +73,12 @@ class CRC32(object):
>>                           help="number of forged names to create")
>>       return parser.parse_args()
>>   
>> +def has_invalid_chars(result: bytes):
>> +    for i in result:
>> +        if i == 0 or i == int.from_bytes(b'/', byteorder="little"):
>> +            return True
>> +    return False
>> +
>>   if __name__=='__main__':
>>   
>>     crc = CRC32()
>> @@ -80,12 +87,15 @@ if __name__=='__main__':
>>     args = crc.parse_args()
>>     dirpath=args.dir
>>     while count < args.count :
>> -    origname = os.urandom (89).encode ("hex")[:-1].strip ("\x00")
>> +    origname = os.urandom (89).hex()[:-1].strip ("\x00")
>>       forgename = crc.forge(wanted_crc, origname, 4)
>> -    if ("/" not in forgename) and ("\x00" not in forgename):
>> +    if not has_invalid_chars(forgename):
>>         srcpath=dirpath + '/' + str(count)
>> -      dstpath=dirpath + '/' + forgename
>> -      file (srcpath, 'a').close()
>> +      # We have to convert all strings to bytes to concatenate the forged
>> +      # name (bytes).
>> +      # Thankfully os.rename() can accept bytes directly.
>> +      dstpath=bytes(dirpath, "ascii") + bytes('/', "ascii") + forgename
>> +      open(srcpath, mode="a").close()
>>         os.rename(srcpath, dstpath)
>>         os.system('btrfs fi sync %s' % (dirpath))
>>         count+=1;
>> diff --git a/tests/btrfs/154 b/tests/btrfs/154
>> index 240c504c..6be2d5f6 100755
>> --- a/tests/btrfs/154
>> +++ b/tests/btrfs/154
>> @@ -21,7 +21,7 @@ _begin_fstest auto quick
>>   
>>   _supported_fs btrfs
>>   _require_scratch
>> -_require_command $PYTHON2_PROG python2
>> +_require_command $PYTHON3_PROG python3
>>   
>>   # Currently in btrfs the node/leaf size can not be smaller than the page
>>   # size (but it can be greater than the page size). So use the largest
>> @@ -42,7 +42,7 @@ _scratch_mount
>>   #    ...
>>   #
>>   
>> -$PYTHON2_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
>> +$PYTHON3_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
>>   echo "Silence is golden"
>>   
>>   # success, all done
>> -- 
>> 2.39.0
>>
> 
